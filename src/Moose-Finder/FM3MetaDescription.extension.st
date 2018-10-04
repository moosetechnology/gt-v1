Extension { #name : #FM3MetaDescription }

{ #category : #'*Moose-Finder' }
FM3MetaDescription >> allComplexAttributes [

	^ self allAttributes reject: [:attr | attr type isPrimitive ]
]

{ #category : #'*Moose-Finder' }
FM3MetaDescription >> allPrimitiveAttributes [

	^ self allAttributes select: [:attr | 
		attr type notNil and: [attr type isPrimitive ]]
]

{ #category : #'*Moose-Finder' }
FM3MetaDescription >> complexAttributes [

	^ self attributes reject: [:attr | attr type isPrimitive ]
]

{ #category : #'*Moose-Finder' }
FM3MetaDescription >> primitiveAttributes [

	^ self attributes select: [:attr | attr type isPrimitive ]
]
