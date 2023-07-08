// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Site {
    struct Student {
        // Personal Details
        string rollNo;
        string name;
        string fatherName;
        string motherName;
        uint256 dateOfBirth;
        string gender;
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

    

    struct Result {
        uint CGPA;
        uint totalCredits;
        uint creditPoints;
    }

    struct MarksGrades {
        string subject;
        uint marks;
        uint grade;
    }

    mapping(address => string[]) coursesRegistered;
    mapping(address => Student) studentDetails;
    mapping(address => bool) validFaculty;
    mapping(string => address) rollNo;
    mapping(string => Result) results;
    mapping(string => MarksGrades[]) grades;

    function validateFaculty(address _facultyAddress) public {
        validFaculty[_facultyAddress] = true;
    }

    modifier onlyValidFaculty() {
        require(validFaculty[msg.sender]);
        _;
    }

    // Function to save rollNo of student corresponding to their account address through which student can login
    function saveRollNo(
        string calldata _rollNo,
        address _studentAddress
    ) external onlyValidFaculty {
        rollNo[_rollNo] = _studentAddress;
    }
    function insertStudentName(
        string calldata _rollNo,
        string calldata _name
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].name = _name;
    }

    function insertStudentDOB(
        string calldata _rollNo,
        uint256 _dateOfBirth
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].dateOfBirth = _dateOfBirth;
    }

    function insertStudentGender(
        string calldata _rollNo,
        string calldata _gender
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].gender = _gender;
    }

    function insertStudentEmail(
        string calldata _rollNo,
        string calldata _email
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].email = _email;
    }

    function insertStudentBloodGroup(
        string calldata _rollNo,
        string calldata _bloodGroup
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].bloodGroup = _bloodGroup;
    }

    function insertStudentMobile(
        string calldata _rollNo,
        uint _studentMobile
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].studentMobile = _studentMobile;
    }

    function insertStudentImage(
        string calldata _rollNo,
        string calldata _image
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].image = _image;
    }

    function insertParentDetails(
        string calldata _rollNo,
        string calldata _fatherName,
        string calldata _motherName,
        uint _fatherMobile,
        uint _motherMobile
    ) external onlyValidFaculty {
        studentDetails[rollNo[_rollNo]].fatherName = _fatherName;
        studentDetails[rollNo[_rollNo]].motherName = _motherName;
        studentDetails[rollNo[_rollNo]].fatherMobile = _fatherMobile;
        studentDetails[rollNo[_rollNo]].motherMobile = _motherMobile;
    }

    function insertEducationDetails(
        address _studentAddress,
        uint256 _dateOfAdmission,
        uint _admissionBatch,
        string calldata _degree,
        string calldata _branch,
        bool _hosteler
    ) public {
        require(validFaculty[msg.sender], "you cannot edit details");
        studentDetails[_studentAddress].dateOfAdmission = _dateOfAdmission;
        studentDetails[_studentAddress].admissionBatch = _admissionBatch;
        studentDetails[_studentAddress].degree = _degree;
        studentDetails[_studentAddress].branch = _branch;
        studentDetails[_studentAddress].hosteler = _hosteler;
    }

    function displayDetails(
        address _studentAddress
    ) public view returns (Student memory) {
        return (studentDetails[_studentAddress]);
    }

    function insertResults(
        string calldata _rollNo,
        uint _CGPA,
        uint _totalCredits,
        uint _creditPoints
    ) public {
        require(validFaculty[msg.sender]);
        results[_rollNo] = Result(_CGPA, _totalCredits, _creditPoints);
    }

    function editResults(
        string calldata _rollNo,
        uint _CGPA,
        uint _totalCredits,
        uint _creditPoints
    ) public {
        require(validFaculty[msg.sender]);
        // require(results[_rollNo]);
        results[_rollNo].CGPA = _CGPA;
        results[_rollNo].totalCredits = _totalCredits;
        results[_rollNo].creditPoints = _creditPoints;
    }

    function showResults(
        string calldata _rollNo
    ) public view returns (Result memory) {
        // require(studentDetails[msg.sender].rollNo==_rollNo,"another account is connected");
        require(
            keccak256(bytes(studentDetails[msg.sender].rollNo)) ==
                keccak256(bytes(_rollNo)),
            "You cannot view another's result"
        );
        return results[studentDetails[msg.sender].rollNo];
    }

    function insertMarksGrades(
        string calldata _rollNo,
        string calldata _subject,
        uint _marks,
        uint _grade
    ) public {
        require(validFaculty[msg.sender], "only faculty");
        grades[_rollNo].push(MarksGrades(_subject, _marks, _grade));
    }

    function editMarksGrades(
        string calldata _rollNo,
        string calldata _subject,
        uint _marks,
        uint _grade
    ) public {
        require(validFaculty[msg.sender], "only faculty");
        for (uint i = 0; i < grades[_rollNo].length; i++) {
            if (
                keccak256(bytes(grades[_rollNo][i].subject)) ==
                keccak256(bytes(_subject))
            ) {
                grades[_rollNo][i].marks = _marks;
                grades[_rollNo][i].grade = _grade;
            }
        }
    }

    function displayMarksGrades(
        string calldata _rollNo
    ) public view returns (MarksGrades[] memory) {
        require(
            keccak256(bytes(studentDetails[msg.sender].rollNo)) ==
                keccak256(bytes(_rollNo)),
            "You cannot view another's grades"
        );
        return grades[_rollNo];
    }

    function insertCourseRegistered(
        address _studentAddress,
        string calldata _courseName
    ) public {
        require(
            validFaculty[msg.sender],
            "Only Faculties can register students for a course."
        );
        coursesRegistered[_studentAddress].push(_courseName);
    }
}
