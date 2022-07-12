//
//  ViewController.swift
//  APIBitcoin
//
//  Created by Ronald Meliton Borda Bernaola on 11/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let bitcoinViewModel: BitcoinViewModel = BitcoinViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task{
            await setUpData()
        }
        setUpView()
    }
    func setUpData() async{
        await bitcoinViewModel.getDataFromAPI()
        print(bitcoinViewModel.bitcoins)
        tableView.reloadData()
    }
    func setUpView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoinViewModel.bitcoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            let bitcoin = bitcoinViewModel.bitcoins[indexPath.row]
            cell.textLabel?.text = bitcoin.name
            return cell
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    Dictionary<String, Rate>.Index
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = pokeViewModel.pokemons[indexPath.row].name.capitalized
//        return cell
//    }
}
