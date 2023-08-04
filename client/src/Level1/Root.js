import { useEffect } from "react";
import { Outlet, useNavigate } from "react-router-dom";

const Root=()=>{
    const navigate=useNavigate();
    useEffect(()=>{
        try{
            if('demo_user' in localStorage){
                console.log(true);
            }
            else{
                navigate('/signup');
            }
        }
        catch (err){
            navigate('/signup');
        }
    },[])
    return (
        <Outlet />
    );
}
export default Root;