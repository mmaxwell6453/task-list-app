import "./App.css";

import { useState } from "react";

const Task = ({ title }) => {
  return <li>{title}</li>;
};

const App = () => {
  const [text, setText] = useState("");
  const [taskList, setTaskList] = useState([]);

  const handleChange = (e) => {
    setText(e.target.value);
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter") {
      setTaskList((prevTaskList) => {
        return [{ id: crypto.randomUUID(), title: text }, ...prevTaskList];
      });
      setText("");
    }
  };

  return (
    <div className="App">
      <ul>
        {taskList.map((task) => (
          <Task key={task.id} title={task.title} />
        ))}
      </ul>
      <input
        type="text"
        value={text}
        onChange={handleChange}
        onKeyDown={handleKeyDown}
        placeholder="+ Add a Task..."
      />
    </div>
  );
};

export default App;
