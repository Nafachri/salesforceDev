/**
 * @description       : 
 * @author            : npz
 * @group             : 
 * @last modified on  : 28-01-2025
 * @last modified by  : npz
**/
import { LightningElement, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class WebinarTicketLWC extends LightningElement {
    @api isModalOpen;
    @api modalTitle;
    @api ticket;
    
    @track isShowModal = false;

    hideModalBox() {
        this.isModalOpen = false;

        const closeEvent = new CustomEvent('modalclose');
        this.dispatchEvent(closeEvent);
    }

    showModalBox() {  
        this.isShowModal = true;
    }

    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Webinar Ticket created successfully!',
            variant: 'success'
        });
        const ticketCreatedEvent = new CustomEvent('ticketcreated');

        this.dispatchEvent(ticketCreatedEvent);
        this.dispatchEvent(toastEvent);
        this.hideModalBox();
    }

    handleError(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: 'An error occurred while creating the ticket. Please try again.',
            variant: 'error'
        });
        this.dispatchEvent(toastEvent);
    }

}