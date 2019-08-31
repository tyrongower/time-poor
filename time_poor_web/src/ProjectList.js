import React, { Component } from 'react';
import axios from "axios";

class ProjectList extends  Component {
    state = {

    }


    componentDidMount() {
        let me  = this;
        axios.get("https://localhost:44364/api/project").then(
            function (response) {
                me.setState(response.data);
            }
        );

    }
    render() {

        return (

        )
    }
}

export default  ProjectList