import getContacts from '@salesforce/apex/CustomContactController.getContacts';
import { LightningElement, track, wire } from 'lwc';

export default class SfLWC extends LightningElement {
    @wire(getContacts) contacts
    // @track isModalOpen = false // modal visibility
    // @track selectedRow = {} // selectedrow data

    handleClick(e){
        alert('Hello button clicked')
    }

    // handleRowAction(event) {
    //     const rowId = event.target.dataset.id;
    //     console.log(event);
    //     const selectedData = this.data.find((row) => row.id === parseInt(rowId, 10));
    //     this.selectedRow = selectedData
    //     this.isModalOpen = true
    // }

    // handleCloseModal(){
    //     this.isModalOpen = false;
    //     this.selectedRow = {};
    // }
}