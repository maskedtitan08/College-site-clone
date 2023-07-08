import "./Student.css"
import { useState } from "react";

const Student = ({ state }) => {
    const [rollNumber, setRollNumber] = useState("");
    const [name, setName] = useState("")
    const { contract } = state;
    console.log(contract);
    const handleSubmit = async() =>{
        await contract.insertStudentName(rollNumber,name);
    }

    return (
        <div className="student">
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    value={rollNumber}
                    onChange={(e) => setRollNumber(e.target.value)}
                    placeholder="Enter Roll Number"
                />
                <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    placeholder="Enter name"
                />

            </form>
        </div>

    )
}

export default Student;