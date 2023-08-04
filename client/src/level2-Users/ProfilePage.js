import { Link } from "react-router-dom";
import MyPost from "./MyPost";
import "./ProfilePage.css";
import { useState } from "react";

const ProfilePage = () => {
  const [show,setShow]=useState(false);
  return (
    <div className="profile-container">
      <h1 className="heading">Welcome, name!</h1>
      <div>
        <h2 className="heading">About Me</h2>
        <p className="paragraph">bio</p>
        <p className="paragraph">Email:</p>
        <Link to="/editProfile">
          <button className="button">Edit Profile</button>
        </Link>
        {!show &&<button className="button" onClick={()=>setShow(true)}>My Posts</button>}
          {show &&<button className="button" onClick={()=>setShow(false)}>Hide Posts</button>}
        
        {show&&<MyPost />}
      </div>
    </div>
  );
};

export default ProfilePage;
