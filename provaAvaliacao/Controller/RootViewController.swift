import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RootViewController: UITableViewController {

    private let viewModel: HeroesViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: HeroesViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    convenience init() {
        self.init(viewModel: HeroesViewModel())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
      configureCell: { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "BorderCell", for: indexPath) as? BorderCell
        cell?.model = item
        return cell ?? UITableViewCell()
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Meus heróis"
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        setupBindings()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    private func setupView() {
        tableView.register(BorderCell.self)
        tableView.rowHeight = BorderCell.rowHeight
    }

    private func setupBindings() {
        tableView.dataSource = nil

        let sections = [
            SectionOfCustomData(header: "Heróis com quem hospedei", items: viewModel.output.recents),
            SectionOfCustomData(header: "Heróis favoritos", items: viewModel.output.favorites)
        ]

        dataSource.titleForHeaderInSection = { dataSource, index in
          return dataSource.sectionModels[index].header
        }

        Observable.just(sections)
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)

        self.viewModel.output.errorMessage
            .drive(onNext: { [weak self] errorMessage in
                guard let strongSelf = self else { return }
                strongSelf.showError(errorMessage)
            })
            .disposed(by: disposeBag)

       self.viewModel.input.reload.accept(())
    }

    private func showError(_ errorMessage: String) {

        let controller = UIAlertController(title: "An error occured",
                                           message: "Oops, something went wrong!", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(controller, animated: true, completion: nil)
    }
}
