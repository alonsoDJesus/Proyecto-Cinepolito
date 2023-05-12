//
//  ViewController.swift
//  cinepolito
//
//  Created by IMAC17 on 24/04/23.
//

import UIKit
import Foundation //para calculara el tamaño de la pantalla

class ViewController: UIViewController {

    let images: [String] = ["increibles","deadpool","at-man"]
    var movies: [Movie]?
    var miWidthScreen = UIScreen.main.bounds.width
    var i = 0
    var iActual = 0
    var movieSeleccionada : Int?
    
    var timer = Timer()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var btnAll: UIButton!
    
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    @IBOutlet weak var CollectionView2: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        CollectionView2.isHidden=true
        activityIndicator.startAnimating()
         Conexion.con.getAll{
             usuario in
             self.movies = usuario
             
             self.MyCollectionView.dataSource = self
             self.MyCollectionView.delegate = self
             
             self.CollectionView2.dataSource = self
             self.CollectionView2.delegate = self
             
             self.activityIndicator.stopAnimating()
             self.CollectionView2.isHidden=false
             
             self.MyCollectionView.register(UINib(nibName: "MyCustom", bundle: nil), forCellWithReuseIdentifier: "myCelda")
             self.CollectionView2.register(UINib(nibName: "PeliculasPrueba", bundle: nil), forCellWithReuseIdentifier: "nuevaCelda")
             self.timer = Timer.scheduledTimer(timeInterval: 1.0,//cada cuando se va a ejecutar
                                               target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
             
             
         } fail: { err in
             self.activityIndicator.stopAnimating()
             print(err.debugDescription)
         }
        
        
        
    }
    
    @objc func timeAction(){
        iActual = MyCollectionView.indexPathsForVisibleItems[0].row+1
       
        if iActual >= movies!.count{
            iActual = 0;
            
        }
                
        MyCollectionView.scrollToItem(at: IndexPath(item: iActual, section: 0), at: .right, animated: true)
         
    }
    
    @IBAction func btnGet(_ sender: Any) {
       
        print(movies!)
        
    }
    
    func verDetallePelicula(i: Int){
        movieSeleccionada = i
        performSegue(withIdentifier: "toMovieDetail", sender: self)
        
    }
    
    // Este mètodo se ejecuta antes que el metodo editarContacto
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetail"{
            if let destino = segue.destination as? MovieDetail{
                destino.m = movies![movieSeleccionada!]
            }
        }
    }
    
}
extension ViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == CollectionView2){
            return movies!.count
        }
        return movies!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//dibuja las celdas
        
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "myCelda", for: indexPath) as? MyCustom
        
        if (collectionView == CollectionView2){
            let cell2 = CollectionView2.dequeueReusableCell(withReuseIdentifier: "nuevaCelda", for: indexPath) as! PeliculasPrueba
            cell2.img.image = UIImage(named: images[indexPath.row])
            cell2.titulo.text = movies![indexPath.row].titulo!
            cell2.genero.text = movies![indexPath.row].genero!
            cell2.idioma.text = movies![indexPath.row].idioma!
            cell2.horarios.text = movies![indexPath.row].horarios!
            cell2.clasificacion.text = movies![indexPath.row].clasificacion!
            
            let url = URL(string: movies![indexPath.row].url_portada!)
            
            cell2.img.kf.setImage(with: url)
            print(indexPath.row)
            return cell2
        }
        // aqui va la imagen correspondiente
        cell?.img.kf.setImage( with: URL(string: movies![indexPath.row].url_portada!) )
        return cell!
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        verDetallePelicula(i:indexPath.row)
    }
}

//permide tibujar las celdas
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  miWidthScreen, height: 250)
    }
}
