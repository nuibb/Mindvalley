
##Requirements
- There are 3 sections. New Episodes , Channels , and Categories .
- These 3 sections should be shown in one view as shown in the design, in that order.
- The channels section has two different design types.
- One is for type Course and the other is for type Series. An example of a Series is
    “Mindvalley on Stage”. Example of a Course is “Impact at Work”
- To differentiate between a Series and a Course, take a look at the Channels object in the JSON provided and follow the pseudocode below -

        If the Series object inside Channels exists
            show the Series design
        else
            show the Course Design 
            
- New Episodes and Channels should be horizontally scrollable with a maximum of 6 being shown per row
- The Course and Series click events do not need to be handled
- All the data should be loaded from the provided API calls.
- Images and JSON should be cached efficiently, so they can be viewed offline
- API Requests/data loading and showing should be done in a way to give the user the best experience. Keep in mind the JSON provided might have some data missing in some instances, so these cases should be handled gracefully to provide a good UX
- It should be responsive to all phone sizes.
- Should have Unit Tests
- Use version control system (Git)

##API
- There is an API in JSON format for each section.
- New Episodes Section ( link )
- Channels Section ( link )
- Categories Section ( link )
