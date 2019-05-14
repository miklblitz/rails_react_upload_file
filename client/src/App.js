import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import axios from 'axios';

class App extends Component {

  state = {
    selectedFile: null
  }

  fileSelectedHandler = event => {
    this.setState({
      selectedFile: event.target.files[0]
    })
  }

  uploadFileHandler = () => {
    const fd = new FormData()
    const options = {
      headers:{
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      onUploadProgress: (progressEvent) => {
        let result = Math.round(progressEvent.loaded / progressEvent.total * 100)
        document.getElementById('progress').innerHTML=result+'%'
        console.log('Uploaded ' + result + '%')
      }
    }
    if (this.state.selectedFile != null)
    fd.append('photo[image]', this.state.selectedFile, this.state.selectedFile.name)
    axios.post('http://localhost:3003/photos', fd, options)
    .then(res => {
      console.log(res)
    });
  }

  render() {
    return (
      <div className="App">
        <input 
          type="file" 
          style={{display:'none'}}
          onChange={this.fileSelectedHandler} 
          ref={fileInput => this.fileInput = fileInput}
        />
        <button onClick={() => this.fileInput.click()}>Pick a file</button>
        <button onClick={this.uploadFileHandler}>Upload</button>
        <div id="progress"></div>
      </div>
    );
  }
}

export default App;
