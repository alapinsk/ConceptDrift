package moa.classifiers.core.driftdetection;

import moa.core.ObjectRepository;
import moa.options.IntOption;
import moa.tasks.TaskMonitor;
import moa.options.FloatOption;
import java.util.LinkedList;
import weka.core.Statistics;


/**
 *
 * <p>NISHIDA, Kyosuke; YAMAUCHI, Koichiro. Detecting concept drift using
 * statistical testing. In: Discovery Science.
 * Springer Berlin Heidelberg, 2007. p. 264-269. </p>
 *
 * @author Andrzej Lapinski on 05.09.2015.
 */

public class STEPD extends AbstractChangeDetector {

    public IntOption minNumInstancesOption = new IntOption(
            "minNumInstances",
            'n',
            "Window of most recent examples size.",
            30, 0, Integer.MAX_VALUE);
    public FloatOption alphaDOption = new FloatOption(
            "alphaD",
            'd', 
            "Drift significance level.",
            0.05);
    public FloatOption alphaWOption = new FloatOption(
            "alphaW",
            'w', 
            "Warning significance level.",
            0.06);


    private LinkedList<Boolean> predictionQueue;
    private double ro, no; // {overall} - {recent}
    private double rr, nr; // {recent}
    private double pHat, pValue;


    public STEPD() { resetLearning(); }

    @Override
    public void resetLearning() {
        this.predictionQueue = new LinkedList();
        this.ro = 0;
        this.no = 0;
        this.rr = 0;
        this.nr = 0;
    }

    @Override
    public void input(double prediction) {

        if (this.isChangeDetected) {
            resetLearning();
        }

        this.isWarningZone = false;
        this.isChangeDetected = false;

        nr++;

        if (prediction == 0) {
            //if correctly predicted
            this.rr++;
            predictionQueue.addFirst(true);
        }
        else
        {
            predictionQueue.addFirst(false);
        }


        if (this.nr > this.minNumInstancesOption.getValue()) {
            //move window one step but retain old as overall count {overall} - {recent}
            if (predictionQueue.removeLast()) {
                this.ro++;
                this.rr--;
            }
            this.no++;
            this.nr--;
        }

        if ( this.no + this.nr >= 2 * this.minNumInstancesOption.getValue()) {
            this.pHat = (this.ro + this.rr) / (this.no + this.nr);
            this.pValue = (Math.abs((this.ro / this.no) - (this.rr / this.nr)) - 0.5 * ((1 / no) + (1 / nr)))
                         / Math.sqrt(pHat * (1 - pHat) * ((1 / no) + (1 / nr)));

            if(this.pValue < 0){
                this.pValue = 0;
            }
            this.pValue = Statistics.chiSquaredProbability(this.pValue, 1); //chi-squared test

            if (this.pValue < this.alphaDOption.getValue()) {
                this.isChangeDetected = true;
            } else if (this.pValue < this.alphaWOption.getValue()) {
                this.isWarningZone = true;
            }
        }
    }

    @Override
    public void getDescription(StringBuilder sb, int indent) {
        // TODO Auto-generated method stub
    }

    @Override
    protected void prepareForUseImpl(TaskMonitor monitor,
                                     ObjectRepository repository) {
        // TODO Auto-generated method stub
    }
}
