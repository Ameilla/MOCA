//
//  Constant.swift
//  WeatherApp
//
//  Created by MAC-Air on 08/09/23.
//

import Foundation
import UIKit

public class Constants {
    var userID : String? {
        return UserDefaultsManager.shared.getUserId()
    }
    
    enum serviceType: String {
        case loginURL = "http:/172.18.23.244/API/doctor_validate.php?email=123&password=123"
        
//        case dashURL = "http://172.20.10.8/API/dashboard.php"
        
        
        static var profileURL : String {
            if let userId = Constants().userID {
                return "http://192.168.76.171/hrapp1/uprofile.php?bioid=\(userId)"
            } else {
                return ""
            }
        }
        static var salaryURL : String {
            if let userId = Constants().userID {
                return "http://192.168.76.171/hrapp1/usalary.php?bioid=\(userId)"
            } else {
                return ""
            }
        }
        
    }
    static let loginUrl: serviceType = .loginURL
//    static let dashUrl: serviceType = .dashURL

}


//Home -- 192.168.1.9
//Sail -- 172.17.59.131
//Amar -- 172.20.10.8
//SSE -- 172.18.23.244


struct APIList{

    
   

    
    static var ipAddress = "http://localhost/MOCA_AME/"
//    static var ipAddress = "http://192.168.1.24/MOCA_AME/"
    
    

    
    static var LogInURL = ipAddress+"login.php"
    
    static var dashURL = ipAddress+"final_Dashboard.php"
    
    static var PatientInfoApi = ipAddress+"patient_info_final.php"
    
    static var ViewPatientApi = ipAddress+"view_patient_details_final.php"
        
//    static var PatientProfilesApi = ipAddress+"patient_profiles.php"
    
    static var AddPatientApi = ipAddress+"add_patient_final.php"
    
    static var deletepatientApi = ipAddress+"delete_patient_final.php?"
    
    static var updatePatientApi = ipAddress+"update_patient.php?id="
    
    static var DoctorProfileApi = ipAddress+"doctor_profile.php"
    
    static var DoctorProfileUpdateApi = ipAddress+"doctor_profile_update.php"
    
//    static var updateDoctorApi = ipAddress+"doctor_profile_update.php"
    
   
    static var QuestionsApi = ipAddress+"Question_final.php"
    static var Question4Api = ipAddress+"Ques_4_final.php"
    static var Question5Api = ipAddress+"Ques_5_final.php"
    static var Question9Api = ipAddress+"Ques_9_final.php"
    static var ResultApi = ipAddress+"result.php"
  
    static var ViewResultApi = ipAddress+"view_result.php?id="
    static var GraphApi = ipAddress+"bar.php?id="
    static var AddCommentApi = ipAddress+"description.php?id="
    
    static var t_QuestionsApi = ipAddress+"t_Question_final.php"
    static var t_Question4Api = ipAddress+"t_Ques_4_final.php"
    static var t_Question5Api = ipAddress+"t_Ques_5_final.php"
    static var t_Question9Api = ipAddress+"t_Ques_9_final.php"
    
}

