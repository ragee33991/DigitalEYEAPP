

import 'Constant.dart';

class DoctorInfo{
  String name;
  String role;
  String image;
  String review;
  String distance;
  double latitude;
  double longitude;
  String address;
  DoctorInfo(this.name,this.role,this.image,this.review,this.distance,this.latitude,this.longitude,this.address);
  
}

List<DoctorInfo> listDoctor = [
       DoctorInfo("Dr Needles", "Oncologist", AppImage.doctorProfile,"4.3","10",23.024338,72.5280573,"815 Thatcher Ave.Santa Ana, CA 92701"),
       DoctorInfo("Dr Seymour Landa", "Optometrist", AppImage.drProfile2,"4.3","6.5",23.0239873,72.525906,"996 Tallwood Street Salinas, CA 93905"),
       DoctorInfo("Dr Lachinet", "Orthopedics", AppImage.drProfile3,"4.6","8",23.024683,72.527290,"93 Cobblestone Lane Reseda, CA 91335"),
       DoctorInfo("Dr Neupane", "Pain Management", AppImage.drProfile4,"4.5","3",23.037964,72.526907,"9450 Nichols Drive Fresno, CA 93722"),
       DoctorInfo("Dr Elfman", "Pediatricians", AppImage.drProfile5,"4.6","6.5",23.024338,72.5280573,"75 Tower Ave.Sacramento, CA 95823"),
       DoctorInfo("Dr Polymeropoulos", "Polymorphism", AppImage.drProfile6,"4.2","6.5",23.024683,72.526907,"56 Essex Dr.Oakland, CA 94601"),
       DoctorInfo("Dr Strange", "Psychiatrists/Psychologists", AppImage.drProfile7,"4.9","4.5",23.0239873,72.525906,"996 Tallwood Street Salinas, CA 93905"),
       DoctorInfo("Dr Albright", "Radiologist", AppImage.drProfile8,"4.6","5.0",23.024338,72.5280573,"9450 Nichols Drive Fresno, CA 93722"),
];



class HospitalInfo{
      String name;
      String description;
      String image;
      String review;
      String distance;
      double latitude;
      double longitude;
      String address;
      HospitalInfo(this.name,this.description,this.image,this.review,this.distance,this.latitude,this.longitude,this.address);
    }

    List<HospitalInfo> hospitalList = [
       HospitalInfo("AHMC Anaheim Regional Medical Center",
      "Staph bacteria are common in hospitals, but Methicillin-resistant Staphylococcus aureus (MRSA) is a type of staph bacteria that is resistant to (cannot be killed by) many antibiotics.",
       AppImage.hispital,
       "4.3","10",
       23.024338,72.5280573,
       "815 Thatcher Ave.Santa Ana, CA 92701"),
       HospitalInfo("AHS Southcrest Hospital, LLC dba Hillcrest Hospital South", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.3","6.5",23.0239873,72.525906,"996 Tallwood Street Salinas, CA 93905"),
       HospitalInfo("AdventHealth East Orlando", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.6","8",23.024683,72.527290,"93 Cobblestone Lane Reseda, CA 91335"),
       HospitalInfo("Baptist Health Louisville", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.5","3",23.037964,72.526907,"9450 Nichols Drive Fresno, CA 93722"),
       HospitalInfo("Baptist Medical Center South", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.6","6.5",23.024338,72.5280573,"75 Tower Ave.Sacramento, CA 95823"),
       HospitalInfo("CHRISTUS Spohn Hospital Kleberg", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.2","6.5",23.024683,72.526907,"56 Essex Dr.Oakland, CA 94601"),
       HospitalInfo("Carlsbad Medical Center", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.9","4.5",23.0239873,72.525906,"996 Tallwood Street Salinas, CA 93905"),
       HospitalInfo("Cumberland Medical Center", "The Becker's Hospital Review editorial team selected hospitals for this list based on rankings and awards from numerous reputable sources, including U.S.", AppImage.hispital,"4.6","5.0",23.024338,72.5280573,"9450 Nichols Drive Fresno, CA 93722"),
];