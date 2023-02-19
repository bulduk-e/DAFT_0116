import streamlit as st
import pandas as pd
import seaborn as sns
from sklearn import datasets
import plotly.figure_factory as ff
import matplotlib.pyplot as plt
import numpy as np

#import math
#import numpy as np
#import datetime
st.set_option('deprecation.showPyplotGlobalUse', False)

breast_cancer = datasets.load_breast_cancer(as_frame=True)

breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)

breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

# setting wide and title
st.set_page_config(layout="wide") 
st.markdown("**[Breast Cancer Stats]**")

### Dropdowns for Scatter Chart
# Select box for x and y axis
selectbox_x = st.selectbox( "Select a value for x:", breast_cancer_df.columns.tolist() )
selectbox_y = st.selectbox( "Select a value for y:", breast_cancer_df.columns.tolist() )
st.write(f"You selected {selectbox_x} for x and {selectbox_y} for y.")

#Scatter Plot  
sns.relplot(x=selectbox_x,y=selectbox_y, data=breast_cancer_df)
st.pyplot()
st.set_option('deprecation.showPyplotGlobalUse', False)

###Multi-Select for Bar Chart
# Multi select
multi_selectbox= st.multiselect("Select measures :", breast_cancer_df.columns.tolist(), key=1)
#Bar chart
select_columns = breast_cancer_df[multi_selectbox]
st.bar_chart(select_columns.mean())

###Multi-Select and Radio Buttons 
# Multi select & Bins
multi_selectbox2= st.multiselect("Select measures :", breast_cancer_df.columns.tolist(), key=2)
filter_bc_df= breast_cancer_df[multi_selectbox2]
# radio button
selected_measure = st.radio('Select measure', multi_selectbox2)
# bin size
bin_size = st.slider("Select a value for bins", min_value=float(0.05), max_value=float(0.5), value=0.05)

#Bar chart with radio button
fig, ax = plt.subplots()
ax.hist(filter_bc_df[selected_measure], bins=np.arange(0,1, bin_size))
ax.set_xlabel(selected_measure)
ax.set_ylabel('Count')
st.pyplot(fig)

# hexbin chart
