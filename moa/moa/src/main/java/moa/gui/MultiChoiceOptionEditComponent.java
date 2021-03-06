/*
 *    MultiChoiceOptionEditComponent.java
 *    Copyright (C) 2007 University of Waikato, Hamilton, New Zealand
 *    @author Richard Kirkby (rkirkby@cs.waikato.ac.nz)
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program. If not, see <http://www.gnu.org/licenses/>.
 *    
 */
package moa.gui;

import javax.swing.JComboBox;

import moa.options.MultiChoiceOption;
import moa.options.Option;

/**
 * An OptionEditComponent that lets the user edit a multi choice option.
 *
 * @author Richard Kirkby (rkirkby@cs.waikato.ac.nz)
 * @version $Revision: 7 $
 */
public class MultiChoiceOptionEditComponent extends JComboBox implements
        OptionEditComponent {

    private static final long serialVersionUID = 1L;

    protected MultiChoiceOption editedOption;

    public MultiChoiceOptionEditComponent(MultiChoiceOption option) {
        super(option.getOptionLabels());
        this.editedOption = option;
        setSelectedIndex(option.getChosenIndex());
    }

    @Override
    public void applyState() {
        this.editedOption.setChosenIndex(getSelectedIndex());
    }

    @Override
    public Option getEditedOption() {
        return this.editedOption;
    }

    @Override
    public void setEditState(String cliString) {
        MultiChoiceOption tempOpt = (MultiChoiceOption) this.editedOption.copy();
        tempOpt.setValueViaCLIString(cliString);
        setSelectedIndex(tempOpt.getChosenIndex());
    }
}
