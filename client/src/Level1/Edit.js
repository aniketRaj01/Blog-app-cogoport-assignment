import React, { useEffect, useState } from 'react';
import NewPost from './NewPost';
import { useParams } from 'react-router-dom';

const Edit = () => {
    const [post,setPost]=useState('');
    const params=useParams();
    const [loading,setLoading]=useState(true);

    useEffect(()=>{
        //console.log(params.id);
        setLoading(true);
        try{
            const posts=JSON.parse(localStorage.getItem('posts'));
            const filterPost=posts.filter((item)=>item.id==params.id);
            setPost(...filterPost);
            //console.log(post);
        }
        catch(err){
            console.log(err);
        }
        setLoading(false);
   },[params.id])

   if(loading){
    return (
        <div>Loading..</div>
    );
   }
  return (
    <div>
        <h2>Edit Post</h2>
        <NewPost initialValues={post}   />
    </div>
  );
};

export default Edit;
