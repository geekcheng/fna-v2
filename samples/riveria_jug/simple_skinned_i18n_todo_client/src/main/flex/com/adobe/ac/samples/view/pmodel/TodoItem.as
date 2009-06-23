package com.adobe.ac.samples.view.pmodel
{
    [Bindable]
    [RemoteClass(alias="com.adobe.ac.samples.model.TodoItem")]
    public class TodoItem 
    {
        private var _id : int;

        private var _title : String;

        /**
         * Default constructor for TodoItemBase.
         */
        public function TodoItem()
        {
        }

        /**
         * Sets the id property.
         */
        public function set id( value : int ) : void
        {
            _id = value;
        }

        /**
         * Returns the id property value. 
         */
        public function get id() : int
        {
            return _id; 
        }

        /**
         * Sets the title property.
         */
        public function set title( value : String ) : void
        {
            _title = value;
        }

        /**
         * Returns the title property value. 
         */
        public function get title() : String
        {
            return _title; 
        }
    }
}