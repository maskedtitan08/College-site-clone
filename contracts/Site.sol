// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Site{

    struct Student{

        // Personal Details
        // address studentAddress;
        string rollNo;
        string name;
        string fatherName;
        string motherName;
        uint256 dateOfBirth;
        string gender;
        string maritalStatus;
        string email;
        uint studentMobile;
        uint fatherMobile;
        uint motherMobile;
        string image;
        string bloodGroup;

        // Education details

        uint256 dateOfAdmission;
        uint admissionBatch;
        string degree;
        string branch;
        bool hosteler;

        
    }

    // struct Faculty{
    //     string name;
    //     uint id;
    //     uint mobileNo;

    // }

    struct Result{
        uint CGPA;
        uint totalCredits;
        uint creditPoints;
    }

    struct MarksGrades{
        string subject;
        uint marks;
        uint grade;
    }

    mapping(address=>string[]) coursesRegistered;
    mapping(address=>Student) studentDetails;
    mapping(address=>bool) validFaculty;
    mapping(string=>address) rollNo;
    mapping(string=>Result) results;
    mapping(string=>MarksGrades[]) grades;

    function validateFaculty(address _facultyAddress)public{
        validFaculty[_facultyAddress]=true;

    }


    function insertDetails(address _studentAddress,string calldata _rollNo,string calldata _name,string calldata _fatherName,string calldata _motherName,uint256 _dateOfBirth,string calldata _gender,string calldata _maritalStatus,string calldata _email,uint _studentMobile,uint _fatherMobile,uint _motherMobile,string calldata _image,string calldata _bloodGroup,
    uint256 _dateOfAdmission,uint _admissionBatch,string calldata _degree,string calldata _branch,bool _hosteler)public{
    require(_studentAddress!=address(0),"Invalid Address");
    studentDetails[_studentAddress] = Student(_rollNo,_name,_fatherName,_motherName,_dateOfBirth,_gender,_maritalStatus,_email,_studentMobile,_fatherMobile,_motherMobile,_image,_bloodGroup,_dateOfAdmission,_admissionBatch,_degree,_branch,_hosteler);
    rollNo[_rollNo]=_studentAddress;

    }

    function editPersonalDetails(address _studentAddress,string calldata _rollNo,string calldata _name,string calldata _fatherName,string calldata _motherName,uint256 _dateOfBirth,string calldata _gender,string calldata _maritalStatus,string calldata _email,uint _studentMobile,uint _fatherMobile,uint _motherMobile,string calldata _image,string calldata _bloodGroup)public{
        require(validFaculty[msg.sender],"you cannot edit details");
        studentDetails[_studentAddress].rollNo=_rollNo;
        studentDetails[_studentAddress].name=_name;
        studentDetails[_studentAddress].fatherName=_fatherName;
        studentDetails[_studentAddress].motherName=_motherName;
        studentDetails[_studentAddress].dateOfBirth=_dateOfBirth;
        studentDetails[_studentAddress].gender=_gender;
        studentDetails[_studentAddress].maritalStatus=_maritalStatus;
        studentDetails[_studentAddress].email=_email;
        studentDetails[_studentAddress].studentMobile=_studentMobile;
        studentDetails[_studentAddress].fatherMobile=_fatherMobile;
        studentDetails[_studentAddress].motherMobile=_motherMobile;
        studentDetails[_studentAddress].image=_image;
        studentDetails[_studentAddress].bloodGroup=_bloodGroup;
    

    }
    function editEducationDetails(address _studentAddress,uint256 _dateOfAdmission,uint _admissionBatch,string calldata _degree,string calldata _branch,bool _hosteler)public{
        require(validFaculty[msg.sender],"you cannot edit details");
        studentDetails[_studentAddress].dateOfAdmission=_dateOfAdmission;
        studentDetails[_studentAddress].admissionBatch=_admissionBatch;
        studentDetails[_studentAddress].degree=_degree;
        studentDetails[_studentAddress].branch=_branch;
        studentDetails[_studentAddress].hosteler=_hosteler;

    }
    function displayDetails(address _studentAddress) public view returns(Student memory){
        return (studentDetails[_studentAddress]);

    }
    function insertResults(string calldata _rollNo,uint _CGPA,uint _totalCredits,uint _creditPoints)public{
        require(validFaculty[msg.sender]);
        results[_rollNo]=Result(_CGPA,_totalCredits,_creditPoints);
    }

    function editResults(string calldata _rollNo,uint _CGPA,uint _totalCredits,uint _creditPoints)public{
        require(validFaculty[msg.sender]);
        // require(results[_rollNo]);
        results[_rollNo].CGPA=_CGPA;
        results[_rollNo].totalCredits=_totalCredits;
        results[_rollNo].creditPoints=_creditPoints;
    }

    function showResults(string calldata _rollNo)view public returns(Result memory){
        // require(studentDetails[msg.sender].rollNo==_rollNo,"another account is connected");
        require(keccak256(bytes(studentDetails[msg.sender].rollNo)) == keccak256(bytes(_rollNo)), "You cannot view another's result");
        return results[studentDetails[msg.sender].rollNo];
    }

    function insertMarksGrades(string calldata _rollNo,string calldata _subject,uint _marks,uint _grade)public{
        require(validFaculty[msg.sender],'only faculty');
        grades[_rollNo].push(MarksGrades(_subject,_marks,_grade));
    }

    function editMarksGrades(string calldata _rollNo,string calldata _subject,uint _marks,uint _grade)public{
        require(validFaculty[msg.sender],'only faculty');
        for(uint i=0;i<grades[_rollNo].length;i++){
            if(keccak256(bytes(grades[_rollNo][i].subject)) == keccak256(bytes(_subject))){
                grades[_rollNo][i].marks=_marks;
                grades[_rollNo][i].grade=_grade;
            }
        }
    }

    function displayMarksGrades(string calldata _rollNo)public view returns(MarksGrades[] memory){
        require(keccak256(bytes(studentDetails[msg.sender].rollNo)) == keccak256(bytes(_rollNo)), "You cannot view another's grades");
        return grades[_rollNo];
    }



    function insertCourseRegistered(address _studentAddress,string calldata _courseName) public {
        require(validFaculty[msg.sender],"Only Faculties can register students for a course.");
        coursesRegistered[_studentAddress].push(_courseName);

    }

    
    

}