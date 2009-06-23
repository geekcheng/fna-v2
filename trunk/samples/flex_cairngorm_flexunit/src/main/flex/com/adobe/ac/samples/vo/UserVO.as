package com.adobe.ac.samples.vo
{
    [Bindable]
    public class UserVO
    {
    	public function UserVO()
    	{
    	}
        
        public var firstname:String;
        public var lastname:String;
        public var isOnline:Boolean;
        
        public function toString() : String
        {
           return firstname + " " + lastname + " - " + ( isOnline ? "Online" : "Offline" );
        }
    }
}