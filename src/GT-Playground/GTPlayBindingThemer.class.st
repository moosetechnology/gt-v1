Class {
	#name : #GTPlayBindingThemer,
	#superclass : #GLMBrickThemerModule,
	#category : #'GT-Playground'
}

{ #category : #rows }
GTPlayBindingThemer >> borderColor [

	^ self themer popupThemer borderColor
]

{ #category : #rows }
GTPlayBindingThemer >> borderWidth [

	^ 1
]

{ #category : #'empty-text' }
GTPlayBindingThemer >> emptyTextColor [

	^ self themer textLightColor
]

{ #category : #'empty-text' }
GTPlayBindingThemer >> emptyTextFontSize [

	^ 13
]

{ #category : #'empty-text' }
GTPlayBindingThemer >> emptyTextPadding [

	^ 15
]

{ #category : #rows }
GTPlayBindingThemer >> padding [

	^ 5
]

{ #category : #icons }
GTPlayBindingThemer >> removeIcon [

	^ GLMUIThemeExtraIcons glamorousRemove
]
