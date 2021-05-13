import coremltools
import tensorflow
scale = 1/255.

output_labels = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','nothing','space']
tf_keras_model = tensorflow.keras.models.load_model('./model_12.h5')
classifier_config = coremltools.ClassifierConfig(output_labels)
coreml_model = coremltools.convert(tf_keras_model,inputs=[coremltools.ImageType()],classifier_config = classifier_config)

coreml_model.author = 'Juan David Torres'
coreml_model.license = 'BSD'
coreml_model.short_description = 'Model to predict american sign language'

# coreml_model.input_description['image'] = '64x64 color image of sign language to predict'
# coreml_model.output_description['output'] = 'Class prediction'

coreml_model.save('asl_conv_total.mlmodel')