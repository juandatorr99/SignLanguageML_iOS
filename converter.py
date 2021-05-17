import coremltools
import tensorflow
scale = 1/255.

output_labels = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','Nothing']
tf_keras_model = tensorflow.keras.models.load_model('../model_asl_complete.h5')
classifier_config = coremltools.ClassifierConfig(output_labels)
coreml_model = coremltools.convert(tf_keras_model,inputs=[coremltools.ImageType()],classifier_config = classifier_config)

coreml_model.author = 'Juan David Torres'
coreml_model.license = 'ASL'
coreml_model.short_description = 'Model to Predict American Sign Language'

coreml_model.save('asl_conv_total.mlmodel')