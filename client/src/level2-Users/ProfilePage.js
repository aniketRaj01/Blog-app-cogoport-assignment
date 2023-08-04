import { Link } from "react-router-dom";
import MyPost from "./MyPost";
const ProfilePage = () => {
    return (
      <div>
        <h1>Welcome, name!</h1>
        <div>
          <h2>About Me</h2>
          <p>bio</p>
          <p>Email:</p>
          <Link to='/editProfile'><button>Edit Profile</button></Link>
          <Link to='/'><button>View Posts</button></Link>
          <MyPost />
        </div>
        
      </div>
    );
  };
  
  export default ProfilePage;
  
  
  
  