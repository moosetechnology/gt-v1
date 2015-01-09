Class {
	#name : #RTFindInAView,
	#superclass : #RTInteraction,
	#category : #'GT-SpotterExtensions-CoreRoassal'
}

{ #category : #hooks }
RTFindInAView >> initializeElement: aView [

	| mb |
	mb := RTMenuBuilder new.
	mb view: aView.
	mb menu: 'Find' callback: [ 
        GTSpotterMorph new
                        width: 400;
                        doLayout;
                        spotterModel: (GTSpotter on: aView);
                        openCenteredInWorld ].
	mb build
]
