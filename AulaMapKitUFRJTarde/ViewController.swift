//
//  ViewController.swift
//  AulaMapKitUFRJTarde
//
//  Created by Student on 02/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var mapaUFRJ: MKMapView!
    
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapaUFRJ.showsUserLocation = true
        setupLocationManager()
        addGesture()
        
        
    }

    //primeira funçao
    //configuraçoes do mapa
    func setupLocationManager(){
        
        locationManager.delegate = self
        
        //definir melhor localização no mapa
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //solicitando permissão do mapa
        locationManager.requestWhenInUseAuthorization()
        
        //definindo ciclo de atualização do mapa
        locationManager.startUpdatingLocation()
        
    }
    
    //segunda função
    //localização do usuário
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0{
            
            if let location = locations.last{
                
                userLocation = location
                print("A localização do usuário é \(userLocation.coordinate)")
                
            }
            
            
        }
        
        
    }
    
    //terceira função
    //reconhece um gesto realizado na tela do dispositivo
    @objc func addAnnotationToMap(gesturesRecognizer: UIGestureRecognizer){
        
        //contante que recebe o toque realizado na tela do dispositivo
        let touchPoint = gesturesRecognizer.location(in: mapaUFRJ)
        
        let newCoordinate: CLLocationCoordinate2D = mapaUFRJ.convert(touchPoint, toCoordinateFrom: mapaUFRJ)
        let newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Gustavo"
        newAnnotation.subtitle = String(describing: "Latitude: \(newCoordinate.latitude) / Longitude: \(newCoordinate.longitude)")
        
        mapaUFRJ.addAnnotation(newAnnotation)
        
    }

    //Quarta função
    //criar o gesto para o app
    func addGesture(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap(gesturesRecognizer:)))
        
        longPress.minimumPressDuration = 0.8
        mapaUFRJ.addGestureRecognizer(longPress)
        
        
    }
    
    
    
    
}

