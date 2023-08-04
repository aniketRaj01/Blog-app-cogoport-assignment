import { Formik } from "formik";
import React from "react";
import * as yup from "yup";
import { Link, useNavigate } from "react-router-dom";

const editProfileSchema=yup.object().shape({
    name:yup.string().required('enter valid name'),
    age:yup.string(),
    username:yup.string().required('enter valid username'),
    bio:yup.string(),
    email:yup.string().email('Enter valid email')

})
const EditProfile=()=>{
    const navigate=useNavigate();
                
    return (
        <div className="container">
            <h2>Edit Profile</h2>
            <Formik initialValues={{username:'',email:'',name:'',age:'',bio:''}} validationSchema={editProfileSchema} onSubmit={(values)=>{
                //console.log(values);
                //localStorage.setItem('demo_user',true);
                //navigate('/');
            }}>
            {({values,handleBlur,handleChange,handleSubmit,errors,touched})=>
                (
                    <form noValidate onSubmit={handleSubmit} className="form">
                        <input name='name' className="input" type='text' placeholder="Enter name" value={values.name} onChange={handleChange} onBlur={handleBlur}/>
                        
                        {touched.name&&errors.name && <div  className="error">{errors.name}</div>}
                        <input name='age'  className="input" type='number' placeholder="age" value={values.age} onChange={handleChange} onBlur={handleBlur}/>
                        {touched.age&&errors.age && <div className="error">{errors.age}</div>}
                        
                        <input name='username'  className="input" type='text' placeholder="username" value={values.username} onChange={handleChange} onBlur={handleBlur}/>
                       
                        {touched.username&&errors.username && <div className="error">{errors.username}</div>}
                        <input name='bio'  className="input" type='text' placeholder="bio" value={values.bio} onChange={handleChange} onBlur={handleBlur}/>
                       
                        <input name='email'  className="input" type='email' placeholder="email" value={values.email} onChange={handleChange} onBlur={handleBlur}/>
                        
                        
                        <button type="submit" className="button">Edit Profile</button>
                    </form>
                )
            }
            </Formik>
            <Link to='/profile'><button className="button">Profile</button></Link>
        </div>
    );
}
export default EditProfile;