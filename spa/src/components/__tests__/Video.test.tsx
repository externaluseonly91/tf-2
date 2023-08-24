import React  from "react"
import { render, screen, cleanup } from "@testing-library/react"
import renderer from 'react-test-renderer'
import Video from "../Video"



// Fix the test in this component, The test are failing right now.

afterEach(()=> {
    cleanup();
})

const videoTestProps = { url:  'https://www.caspar-health.com', title: "shoulder exercise" }


test('should render video component', ()=> {
    render(<Video video= {videoTestProps}/>)  
    const videoElement = screen.getByTestId("video-card");
    expect(videoElement).toBeInTheDocument();
    expect(videoElement).toHaveLength(3)
}) 


test('matches the snapshot', ()=> {
    const tree = renderer.create(<Video video={videoTestProps} />)
    expect(tree).toMatchSnapshot();
})