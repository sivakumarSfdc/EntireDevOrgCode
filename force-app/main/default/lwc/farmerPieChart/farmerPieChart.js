import { LightningElement, wire, track } from 'lwc';
import getAgriRec from '@salesforce/apex/AgriFarmerController.getAgriRec';
import { refreshApex } from '@salesforce/apex';
import { loadScript } from 'lightning/platformResourceLoader';
import ChartJs from '@salesforce/resourceUrl/ChartJs';

export default class FarmerPieChart extends LightningElement {
    @track records = [];
    @track error;
    wiredDataResult;
    isChartJsInitialized = false;
    chart;

    config = {
        type: 'pie',
        data: {
            labels: ['Final Expenditure', 'Earned Income', 'Profit'],
            datasets: [{
                label: 'Data',
                data: [0, 0, 0],
                backgroundColor: [
                    'rgba(255, 0, 0, 0.9)',
                    'rgba(120, 251, 103, 0.9)',
                    'rgba(255, 255, 0, 0.9)'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            title: {
                display: true,
                text: 'Farmer Status'
            }
        }
    };

    renderedCallback() {
        if (this.isChartJsInitialized) {
            return;
        }
        this.isChartJsInitialized = true;
        loadScript(this, ChartJs)
            .then(() => {
                this.initializePieChart();
                if (this.records.length > 0) {
                    this.updateChart(this.records[0].name, this.records[0].finalExp, this.records[0].earned, this.records[0].profit);
                }
            })
            .catch(error => {
                console.error('Error loading Chart.js', error);
            });
    }

    initializePieChart() {
        const ctx = this.template.querySelector('canvas').getContext('2d');
        this.chart = new window.Chart(ctx, this.config);
    }

    @wire(getAgriRec)
    wiredAgriRec(result) {
        this.wiredDataResult = result;
        const { data, error } = result;
        if (data) {
            this.records = data;
            if (this.isChartJsInitialized && this.chart) {
                this.updateChart(data[0].name, data[0].finalExp, data[0].earned, data[0].profit);
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }

    connectedCallback() {
        this.refreshData();
    }

    refreshData() {
        console.log('Inside refresh block');
        return refreshApex(this.wiredDataResult);
    }

    updateChart(name, finalExp, earned, profit) {
        if (this.chart) {
            this.chart.data.datasets[0].data = [finalExp, earned, profit];
            this.chart.options.title.text = name;
            this.chart.update();
            this.initializePieChart();
        } else {
            console.error('Chart object is not initialized');
        }
    }
}