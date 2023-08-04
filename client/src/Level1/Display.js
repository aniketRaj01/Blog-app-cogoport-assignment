import PostList from "./PostList";
import NavBar from "./NavBar";
import { useState } from "react";
import SignUp from "../level2-Users/SignUp";
import { Link } from "react-router-dom";

const post = [
    {
      id:1,
      title: 'Introduction to React',
      topic: 'Technology',
      image: 'https://via.placeholder.com/300',
      text: 'In this article, we will introduce you to the basics of React and its core concepts.',
      datetime: '2023-08-03T12:00',
      author: 'John Doe',
    },
    {
      id:2,
      title: 'The Art of Writing',
      topic: 'Writing',
      image: 'https://example.com/writing-art.jpg',
      text: 'Discover the secrets of becoming a skilled and prolific writer in this insightful article.',
      datetime: '2023-08-02T15:30',
      author: 'Jane Smith',
    },
    {
      id:3,
      title: 'Healthy Eating Habits',
      topic: 'Health',
      image: 'https://example.com/healthy-eating.jpg',
      text: 'Learn about the importance of maintaining healthy eating habits and its impact on overall well-being.',
      datetime: '2023-08-01T10:15',
      author: 'Alex Johnson',
    },
    {
      id:4,
      title: 'Introduction to java',
      topic: 'Technology',
      image: 'https://example.com/react-intro.jpg',
      text: 'In this article, we will introduce you to the basics of React and its core concepts.',
      datetime: '2023-08-03T12:00',
      author: 'John Doe',
    },
    // Add more posts here
  ];
localStorage.setItem('posts',JSON.stringify(post));
const Display=()=>{
    const [search,setSearch]=useState('');
    const [filter,setFilter]=useState({
        author:'',
        date:'',
        likes:'',
        comments:'',
    });
    const searchHandler=(searchText)=>{
        setSearch(searchText);
    }
    const filterHandler=(filterValues)=>{
        setFilter(filterValues);
    }
    return (
        <>
            <NavBar searchHandler={searchHandler} sendFilter={filterHandler}/>
            <PostList searchText={search} filter={filter}/>
        </>
    );
}
export default Display;