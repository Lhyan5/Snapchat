//
//  ElegirUsuarioViewController.swift
//  Snapchat
//
//  Created by MAC01 on 16/05/19.
//  Copyright © 2019 Lhyan. All rights reserved.
//

import UIKit

class ElegirUsuarioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @IBOutlet weak var listaUsuarios: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaUsuarios.delegate = self
        listaUsuarios.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
