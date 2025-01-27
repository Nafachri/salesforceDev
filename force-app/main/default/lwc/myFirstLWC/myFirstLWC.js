import { LightningElement, wire, api, track } from 'lwc';
import getProjects from '@salesforce/apex/ProjectController.getProjects';

export default class DataVisualization extends LightningElement {
    @api name;
    projects = [];
    error;
    inputValue = '';  // Store the value from the input field
    dynamicMessage = 'This is default value bro!';  // Default message

    handleInputChange(event) {
        this.inputValue = event.target.value;  // Capture input value as the user types
    }
        
    // Handle button click to update the dynamic message
    handleClick() {
        this.dynamicMessage = this.inputValue;   // Update the dynamic message with input value
        this.inputValue = ''; // Clear the input after clicking the button
    }

    // Wire the Apex method to get data
    @wire(getProjects)
    wiredProjects({ error, data }) {
        if (data) {
            this.projects = data.map(project => ({
                id: project.Id,
                name: project.Name,
                projectBudget: project.Project_Budget__c,
                startDate: project.Start_Date__c,
                endDate: project.End_Date__c,
                status: project.Project_Status__c
            }));
        } else if (error) {
            this.error = error;
            console.error('Error retrieving projects: ', error);
        }
    }

    // Define columns for the lightning-datatable
    columns = [
        { label: 'Name', fieldName: 'name' },
        { label: 'Project Budget', fieldName: 'projectBudget' },
        { label: 'Start Date', fieldName: 'startDate' },
        { label: 'End Date', fieldName: 'endDate' },
        { label: 'Project Status', fieldName: 'status' }
    ];
}