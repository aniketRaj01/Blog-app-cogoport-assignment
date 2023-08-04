import './App.css';
import PostList from './Level1/PostList';

import {
  createBrowserRouter,RouterProvider
} from "react-router-dom";
import React from 'react';
import './App.css'
import NewPost from './Level1/NewPost';
import Edit from './Level1/Edit';
import Display from './Level1/Display';
import SignUp from './level2-Users/SignUp';
import Login from './level2-Users/Login';
import ProfilePage from './level2-Users/ProfilePage';
import EditProfile from './level2-Users/EditProfile';
import AuthorList from './level2-Users/AuthorsList';
import PostDetails from './Level1/PostDetails';
import BestPosts from './level3/BestPosts';
import Root from './Level1/Root';
const router=createBrowserRouter([
{
  path:'/',
  element:<Root />,
  children:[
    {
      index:true,element:<Display />
    },
    {
      path:'profile',
      element:<ProfilePage />
    },
    {
      path:'editProfile',
      element:<EditProfile />
    },
    {
      path:'authors',
      element:<AuthorList />
    },
    {
      path:'post-details/:id',
      element:<PostDetails />
    },
    {
      path:'best-posts',
      element:<BestPosts />
    },
    {
      path:'add',
      element:<NewPost />
    },
    {
      path:'edit/:id',
      element:<Edit />
    }
  ]
},
{
  path:'signup',
  element:<SignUp />
},
{
  path:'login',
  element:<Login />
},

])

function App() {
  return (
    <React.StrictMode>
      <RouterProvider router={router}/>
    </React.StrictMode>
  
  );
}

export default App;

