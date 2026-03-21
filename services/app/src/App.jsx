import './App.css'

function App() {
  return (
    <div className="container">
      <h1 className="title">🚀 DevOps Pipeline Live</h1>
      <p className="subtitle">React app deployed via Jenkins + Docker + ECR</p>

      <div className="card">
        <p>Build Status: <span className="status">SUCCESS</span></p>
        <p>Environment: Production</p>
      </div>

      <p className="footer">Version: v1</p>
    </div>
  )
}

export default App
