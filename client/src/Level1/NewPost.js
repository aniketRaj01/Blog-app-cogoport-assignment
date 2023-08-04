import React, { useEffect ,useState} from 'react';
import { Formik, ErrorMessage } from 'formik';
import * as yup from 'yup';
import { Link } from 'react-router-dom';
import './NewPost.css'

const NewPost = (props) => {
    const [loading,setLoading]=useState(true);
    let initialValues = {
        title: '',
        topic: '',
        image: '',
        text: '',
        author: '',
      };;
      try{
        //console.log(props.initialValues);
        initialValues= {
            title: props.initialValues.title,
            topic: props.initialValues.topic,
            image: props.initialValues.image,
            text: props.initialValues.text,
            author: props.initialValues.author,
          }
    }
    catch (err){
        console.log(err);
    }
    
    //console.log(initialValues)
  const validationSchema = yup.object({
    title: yup.string().required('Title is required'),
    topic: yup.string(),
    image: yup.string(),
    text: yup.string().required('Text is required'),
    author: yup.string().required('Author is required'),
  });
  
  return (
    <div className='container'>
         <Formik initialValues={initialValues} validationSchema={validationSchema} onSubmit={(values,{resetForm})=>{
        console.log(values);
        //add or edit in local storage
        
        resetForm();
    }}>
      {({values,handleBlur,handleChange,handleSubmit,errors,touched})=>(
        <form noValidate onSubmit={handleSubmit} className="newpost-form">
            <div>
          <input type="text" name="title" placeholder="Title"  value={values.title} onChange={handleChange} onBlur={handleBlur} className="newpost-input"/>
          {touched.title &&errors.title && <div className="newpost-error">{errors.title}</div>}
        </div>
        <div>
          <input type="text" name="topic" placeholder="Topic" value={values.topic} onChange={handleChange} onBlur={handleBlur} className="newpost-input" />
          
        </div>
        <div>
          <input type="text" name="image" placeholder="Featured Image URL" value={values.image} onChange={handleChange} onBlur={handleBlur} className="newpost-input"/>
          <ErrorMessage name="image" component="div" className="newpost-error" />
        </div>
        <div>
          <input type="text" name="text" placeholder="Text" value={values.text} onChange={handleChange} onBlur={handleBlur} className="newpost-input"/>
          <ErrorMessage name="text" component="div" className="newpost-error"/>
        </div>
        <div>
          <input type="text" name="author" placeholder="Author" value={values.author} onChange={handleChange} onBlur={handleBlur} className="newpost-input"/>
          <ErrorMessage name="author" component="div" className="newpost-error" />
        </div>
        <button type="submit" className="newpost-button">Add Post</button>
        </form>
      )}
    </Formik>
    <Link to='/'><button className="newpost-button">View Posts</button></Link>
    </div>
  );
};

export default NewPost;
