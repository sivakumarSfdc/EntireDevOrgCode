import { LightningElement } from 'lwc';

export default class LoopingLWCComponent extends LightningElement {
    EmpListProperty;
    EmpListShowHandler(event){
        this.EmpListProperty = [{
                                  id : 1,
                                  name : 'Rajesh',
                                  title : 'Sr.Developer'},
                                {
                                    id : 2,
                                    name : 'Mahesh',
                                    title : 'Jr.Developer'},
                                {
                                    id : 3,
                                    name : 'Suresh',
                                    title : 'Manager'},
                                {   id : 4,
                                    name : 'Srinvas',
                                    title : 'Product Manager'}

        ];
    }
}