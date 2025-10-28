import React, { useEffect, useState } from "react";

function App() {
  const [msg1, setMsg1] = useState("");
  const [msg2, setMsg2] = useState("");
  const [msg3, setMsg3] = useState("");

  useEffect(() => {
    fetch("/backend1/").then(r => r.json()).then(d => setMsg1(d.message));
    fetch("/backend2/").then(r => r.json()).then(d => setMsg2(d.message));
    fetch("/backend3/").then(r => r.json()).then(d => setMsg3(d.message));
  }, []);

  return (
    <div>
      <h1>React Frontend</h1>
      <p>Backend1: {msg1}</p>
      <p>Backend2: {msg2}</p>
      <p>Backend3: {msg3}</p>
    </div>
  );
}

export default App;
