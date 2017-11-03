//
//  DataTableViewController.swift
//  ParsingDataSubject
//
//  Created by Rizki Syaputra on 11/3/17.
//  Copyright © 2017 Rizki Syaputra. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController {
    
    let kivaLoanURL = "https://android-examples.000webhostapp.com/all_subjects.php"
    //deklarasi variable loans untuk memanggil class loan yang sudah dibuat sebelumnya
    var Subject = [DataSubject]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //mengambil data dari API Loans
        getLatestLoans()
        
        //self sizing cells
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row Table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Subject.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellSubject
        
        // Configure the cell...
        //memasukkan nilainNya kedalam masing2 label
        cell.labelId.text = Subject[indexPath.row].id
        cell.labelSubject.text = Subject[indexPath.row].subject_Name
        
        
        return cell
    }
    
    func getLatestLoans() {
        //deklarasi loanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasi sebelumnya
        guard let loanUrl = URL(string: kivaLoanURL) else {
            return //return ini berfungsi untuk mengembalikan nilai yang sudah didapat ketik memanggil variable loanUrl
        }
        
        //deklarasi request untuk request URL loanUrl
        let request = URLRequest(url: loanUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengembalikkan nilai error yang didapat
            }
            
            // parse JSON data
            //deklarasi variable data untuk memanggil data
            if let data = data {
                //pada bagian ini kita akan memanggil method parseJsonData yang akan kita buat dibawah
                self.Subject = self.parseJsonData(data: data)
                
                //reload tableView
                OperationQueue.main.addOperation ({
                    //reloadData kembali
                    self.tableView.reloadData()
                })
            }
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama parseJsonData
    //method ini akan melakukkan parsing data json
    func parseJsonData(data: Data) -> [DataSubject] {
        //deklarasi variable loans sebagai objek dari class Loan
        var students = [DataSubject]()
        //akan melakukkan perulangan terhadap data json yang d parsing
        do {
            //deklarasi jsonResult untuk mengambil data dari jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResult yang bernama Loans
            let jsonStudents = jsonResult?[""] as! [AnyObject]
            //akan melakuan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonStudents in jsonStudents {
                //deklarasi loan sebagai objek dari class Loan
                let student = DataSubject()
                //memasukkan nilai kedalam masing2 objek dari class Loan
                //memasukkan nilai jsonLoan dengan nama object sebagai String
                student.id = jsonStudents["id"] as! String
                //memasukkan nilai jsonLoan dengan nama objek loan_amount sebagai integer
                student.subject_Name = jsonStudents["subject_Name"] as! String
                //memasukkan nilai jsonLoan dengan nama object use sebagai String
//                student.email = jsonStudents["email"] as! String
                //memasukkan nilai jsonLoan dengan nama object location sebagai String
                //                let address = jsonStudents["address"] as! [String:AnyObject]
                //memasukkan nilai jsonLoan dengan nama object country sebagai String
//                student.adress = jsonStudents["address"] as! String
//                student.home = jsonStudents["home"] as! String
//                student.mobile = jsonStudents["mobile"] as! String
//                student.office = jsonStudents["office"] as! String
                //proses memasukkan data kedalam object
                students.append(student)
            }
        }catch{
            print(error)
        }
        return students
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
