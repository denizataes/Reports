class Statics {
    
    static var baseURL: String = "192.168.1.89"
    
    
    //MARK: Registration
    
    static var reg_EncounterStatusURL: String {
         return "http://" + baseURL + "*****/Mobile/GetRegEncounterStatus"
     }
     
     static var reg_EncounterTypeURL: String {
         return "http://" + baseURL + "*****/Mobile/GetRegEncounterType"
     }
    
    static var reg_NationalityURL: String {
        return "http://" + baseURL + "*****/Mobile/GetRegNationality"
    }
    
    static var reg_AgeURL: String {
        return "http://" + baseURL + "*****/Mobile/GetRegPatientAge"
    }
    
    //MARK: Appointment
    
    static var app_HistoryURL: String {
         return "http://" + baseURL + "*****/Mobile/GetAppointmentHistoryCapacity"
     }
     
     static var app_CurrentURL: String {
         return "http://" + baseURL + "*****/Mobile/GetAppointmentCurrentCapacity"
     }
    
    static var app_NationalityURL: String {
        return "http://" + baseURL + "*****/Mobile/GetAppointmentNationality"
    }
    
    static var app_AgeURL: String {
        return "http://" + baseURL + "*****/Mobile/GetAppointmentAgeGender"
    }
    
    //MARK: Clinical
    
    static var clinic_DoctorURL: String {
         return "http://" + baseURL + "*****/Mobile/GeClinicDoctor"
     }
     
     static var clinic_ReferralURL: String {
         return "http://" + baseURL + "*****/Mobile/GetClinicReferral"
     }
    
    static var clinic_OperationURL: String {
        return "http://" + baseURL + "*****/Mobile/GetClinicOperation"
    }
    
    static var clinic_SicknessURL: String {
        return "http://" + baseURL + "*****/Mobile/GetClinicSickness"
    }
    
    static var clinic_EncounterURL: String {
        return "http://" + baseURL + "*****/Mobile/GetClinicEncounterDuration"
    }
    
    
    //MARK: Finance
    
    static var fin_CoverageFacilityURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceCoverageFacility"
    }
    static var fin_CoverageUnitURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceCoverageUnit"
    }
    static var fin_CoverageUserURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceCoverageUser"
    }
    static var fin_CoverageDoctorURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceCoverageDoctor"
    }
    static var fin_InvoiceFacilityURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceInvoiceFacility"
    }    
    static var fin_InvoiceUnitURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceInvoiceUnit"
    }
    static var fin_InvoiceUserURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceInvoiceUser"
    }
    static var fin_InvoiceDoctorURL: String {
        return "http://" + baseURL + "*****/Mobile/GetFinanceInvoiceDoctor"
    }
    

    //MARK: Information
    
    static var doctorURL: String {
        return "http://" + baseURL + "*****/Mobile/GetDoctors"
    }
    
    static var unitURL: String {
        return "http://" + baseURL + "*****/Mobile/GetUnits"
    }
    
    static var sicknessURL: String {
        return "http://" + baseURL + "*****/Mobile/GetSicknesses"
    }
    
    static var userURL: String {
        return "http://" + baseURL + "*****/Mobile/GetUsers"
    }
    
    static var loginURL: String {
        return "http://" + baseURL + "*****/Mobile/Login"
    }
    
}
