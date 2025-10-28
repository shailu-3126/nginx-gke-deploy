import React from 'react';

function App() {
  const call = async (path) => {
    const r = await fetch(path);
    const j = await r.json();
    alert(JSON.stringify(j));
  };
  return (
    <div style={{padding:20}}>
      <h1>React Frontend</h1>
      <button onClick={()=>call('/api1')}>Call /api1</button>
      <button onClick={()=>call('/api2')}>Call /api2</button>
      <button onClick={()=>call('/api3')}>Call /api3</button>
    </div>
  );
}

export default App;

