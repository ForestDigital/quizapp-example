----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local Wrapper = require("wrapper")
local testData
local myParagraph
local questions = {}
local answerKey = {}
local responses = {}
local selectedAnswer
local contentArea
local question_counter
local returnButton
local markResponse
local nextQuestion
local correct_responses
local contentScreen
local textOn

---------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	testData = event.params.currentTest
	question_counter = 0
	textOn = true
	correct_responses = 0
	

	
	for i=1, 10 do
		x = ((display.contentWidth/10)*i) - display.contentWidth/20
		y = display.contentHeight/20

		responses[i] = display.newImageRect("question_count_current.png", 20, 20)
		responses[i].x = x
		responses[i].y = y
		responses[i].answered = false;
		
		btOptions = {
				text = i,
				x = responses[i].x,
				y = responses[i].y,
				font = native.systemFont,
				fontSize = 10
		}

		local btnText = display.newText(	btOptions )
		btnText:setFillColor(0)
		

	 sceneGroup:insert(responses[i])
	 sceneGroup:insert(btnText)
	end

	for i=1,3 do
		X = display.contentWidth/2
		Y = (display.contentHeight/2) + ((display.contentHeight/9)*i)

		questions[i] = display.newImageRect("answer_x.png", display.contentWidth*0.92, display.contentHeight*0.077)
		questions[i].x = X
		questions[i].y = Y

		local f = function()
			selectedAnswer = answerKey[i]
				markResponse(answerKey[i])
				for j=1,3 do
					if(answerKey[j] == true) then
						questions[j]:setFillColor(0,1,0)
					else
						questions[j]:setFillColor(1,0,0)
					end
				end		
		end

		questions[i].text = display.newText({text = "", x = X, y = Y, font = native.systemFont, fontSize = 13, align = "center", width = display.contentWidth*0.8})
		questions[i].text:addEventListener("tap", f)
		questions[i].text:setFillColor(0)

		sceneGroup:insert(questions[i])
		sceneGroup:insert(questions[i].text)
	end

	contentScreen = display.newImageRect( "question_screen.png", display.actualContentWidth, 0)
	contentScreen.x, contentScreen.y = display.contentWidth/2, display.contentHeight/3.1
	contentScreen.anchorX = 0.5
	contentScreen.anchorY = 0.5

	contentScreen:toBack()
	sceneGroup:insert(contentScreen)
	
	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
end

function markResponse( response )
	if(responses[question_counter].answered == false) then
		if(response == true) then
			responses[question_counter]:setFillColor(0,1,0)
			correct_responses = correct_responses + 1
		else
			responses[question_counter]:setFillColor(1,0,0)
		end
		responses[question_counter].answered = true
	end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	testData = event.params.currentTest
	question_counter = 0
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

	

	transition.to(contentScreen, {y = display.contentHeight/2.2, height = display.actualContentHeight*0.85, time = 1500
					})
		
		
			contentArea = widget.newScrollView(
			    {
			        x = display.contentWidth*0.5,
			        y = display.contentHeight*0.47,
			        width = display.contentWidth*0.95,
			        height = display.contentHeight*0.7,
			        scrollWidth = 600,
			        scrollHeight = 800,
			        horizontalScrollDisabled = true
			    })	--contentArea:setFillColor(1,0,0)
			    sceneGroup:insert(contentArea)

			    contentArea.isVisible = false

			    myParagraph = Wrapper:newParagraph({
					text = testData.text,
					width = display.contentWidth*0.9,
					height = display.contentHeight*0.75, 		-- fontSize will be calculated automatically if set 
					font = "Times New Roman", 	-- make sure the selected font is installed on your system
					fontSize = 16,			
					lineSpace = 2,
					alignment  = "left",
					
					-- Parameters for speed tweaking, just relevant if height is set
					fontSizeMin = 20,
					fontSizeMax = 40,
					incrementSize = 2
					})

					myParagraph:setTextColor({0,0,0})
				contentArea:insert(myParagraph)
			
		timer.performWithDelay(2000,function()
			contentArea.isVisible = true
		end)

		composer.removeHidden()

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end


function scene:destroy( event )
	local sceneGroup = self.view
	contentArea:removeSelf()
	display.remove(myParagraph)
	myParagraph = nil
	for i=1,3 do
			questions[i].text.text = ""
		end
	print("destroyed quizscreen")
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

function scene:backPressed()
	local sceneGroup = self.view
	-- body
	if (question_counter==0) then
		composer.gotoScene("levelselect",{effect = "fade",time = 500})
	elseif (question_counter==1) then
		transition.to(contentScreen, {y = display.contentHeight/2.2, height = display.actualContentHeight*0.85, time = 1500
					})

		contentArea:removeSelf()

		myParagraph = nil

		contentArea = widget.newScrollView(
	    {
	        x = display.contentWidth*0.5,
	        y = display.contentHeight*0.47,
			width = display.contentWidth*0.95,
			height = display.contentHeight*0.7,
	        scrollWidth = 600,
	        scrollHeight = 800,
	        horizontalScrollDisabled = true
	    })	--contentArea:setFillColor(1,0,0)
	    sceneGroup:insert(contentArea)
	    contentArea.isVisible = false
	    myParagraph = Wrapper:newParagraph({
		text = testData.text,
		width = display.contentWidth*0.9,
		height = display.contentHeight/3, 		-- fontSize will be calculated automatically if set 
		font = "Times New Roman", 	-- make sure the selected font is installed on your system
		fontSize = 16,			
		lineSpace = 2,
		alignment  = "left",
		
		-- Parameters for speed tweaking, just relevant if height is set
		fontSizeMin = 20,
		fontSizeMax = 40,
		incrementSize = 2
		})
		myParagraph:setTextColor({0,0,0})
		contentArea:insert(myParagraph)

		timer.performWithDelay(2000,function()
			contentArea.isVisible = true
		end)

		textOn = true

		for i=1,3 do
			questions[i].text.isHitTestable = false
		end

	elseif (question_counter < 10) then
		display.remove(returnButton)
		transition.to(contentScreen, {y = display.contentHeight/3.1, height = display.actualContentHeight*0.45, time = 800
						})

		contentArea:removeSelf()
		myParagraph = nil
		
		contentArea = widget.newScrollView(
	    {
	        x = display.contentWidth*0.5,
	        y = display.contentHeight/3.1,
	        width = display.contentWidth*0.95,
	        height = display.contentHeight*0.4,
	        scrollWidth = 600,
	        scrollHeight = 800,
	        horizontalScrollDisabled = true
	    })	--contentArea:setFillColor(1,0,0)
	    sceneGroup:insert(contentArea)

		myParagraph = Wrapper:newParagraph({

		text = testData.questions[question_counter-1].text,
		width = display.contentWidth*0.9,
		--height = display.contentHeight/3, 		-- fontSize will be calculated automatically if set 
		font = "Times New Roman", 	-- make sure the selected font is installed on your system
		fontSize = 30,			
		lineSpace = 2,
		alignment  = "left",
		
		-- Parameters for speed tweaking, just relevant if height is set
		fontSizeMin = 20,
		fontSizeMax = 40,
		incrementSize = 2
		})
		myParagraph:setTextColor({0,0,0})
		contentArea:insert(myParagraph)
		

		for i=1,3 do
			questions[i]:setFillColor(1,1,1)
			--questions[i]:setLabel(testData.questions[question_counter-1].answers[i].choice)
			questions[i].text.text = testData.questions[question_counter-1].answers[i].choice
			answerKey[i] = testData.questions[question_counter-1].answers[i].correct
		end
	else
		display.remove(returnButton)
	end

	question_counter = question_counter-1
	--print("backbtn touched\n")
	--print("\nquestion_counter == " .. question_counter)
end

function scene:nextPressed()
	local sceneGroup = self.view
	-- body
		if (question_counter < 10) then
			
			transition.to(contentScreen, {y = display.contentHeight/3.1, height = display.actualContentHeight*0.45, time = 800
						})
		
			display.remove(myParagraph)
			contentArea:removeSelf()
			display.remove( contentArea )
			myParagraph = nil
			
			contentArea = widget.newScrollView(
		    {
		        x = display.contentWidth*0.5,
		        y = display.contentHeight/3.1,
		        width = display.contentWidth*0.95,
		        height = display.contentHeight*0.4,
		        scrollWidth = 600,
		        scrollHeight = 800,
		        horizontalScrollDisabled = true
		    })	--contentArea:setFillColor(1,0,0)
		    sceneGroup:insert(contentArea)

			myParagraph = Wrapper:newParagraph({

			text = testData.questions[question_counter+1].text,
			width = display.contentWidth*0.9,
			--height = display.contentHeight*0.75, 		-- fontSize will be calculated automatically if set 
			font = "Times New Roman", 	-- make sure the selected font is installed on your system
			fontSize = 30,			
			lineSpace = 2,
			alignment  = "left",
			
			-- Parameters for speed tweaking, just relevant if height is set
			fontSizeMin = 20,
			fontSizeMax = 40,
			incrementSize = 2
			})
			myParagraph:setTextColor({0,0,0})
			contentArea:insert(myParagraph)
			

			for i=1,3 do
				questions[i]:setFillColor(1,1,1)
				--questions[i]:setLabel(testData.questions[question_counter+1].answers[i].choice)
				questions[i].text.text = testData.questions[question_counter+1].answers[i].choice
				questions[i].text.isHitTestable = true
				answerKey[i] = testData.questions[question_counter+1].answers[i].correct		
			end
			
		--end
		question_counter= question_counter+1
		textOn = false
		--print("nextbtn touched")
		--print("\nquestion_counter == " .. question_counter)
	else
		display.remove(myParagraph)
		display.remove( contentArea )			

		transition.to(contentScreen, {y = display.contentHeight/2.2, height = display.actualContentHeight*0.85, time = 1500
				})

		contentArea = widget.newScrollView(
		    {
		        x = display.contentWidth*0.5,
		        y = display.contentHeight/3.1,
		        width = display.contentWidth*0.95,
		        height = display.contentHeight*0.4,
		        scrollWidth = 600,
		        scrollHeight = 800,
		        horizontalScrollDisabled = true
		    })	--contentArea:setFillColor(1,0,0)
		    sceneGroup:insert(contentArea)

		    local t
		    if (correct_responses < 10) then
		    	t = correct_responses .. "/10" .. " You're getting there!\n"
		    	f = 25
		    else
		    	t = correct_responses .. "/10" .. " \nPerfect!! "
		    	f = 40
		    	for i=1,20 do
		    		local s = display.newImageRect("star.png", display.contentWidth/10, display.contentWidth/10)
		    		s.y = 0
		    		s.x = display.contentWidth*0.5 + math.random(-(s.width*2),(s.width*2))

		    		dx = display.contentWidth*0.5 + math.random(-(s.width*3),(s.width*3))
		    		dy = display.contentHeight + math.random(-(s.width*3),(s.width*3))
		    		s.rotation = math.random(0,360)

		    		local rm = function() s:removeSelf() end
		    		transition.to(s, {time = 4000, x = dx, y = dy, onComplete=rm, transition=easing.inOutSine})
		    	end
		    end

			myParagraph = display.newText({text = t, x = display.contentWidth*0.45, y = display.contentHeight/6, font = native.systemFont, fontSize = f, align = "center", width = display.contentWidth*0.8})
			myParagraph:setFillColor(0)
			contentArea:insert(myParagraph)

			local wh = display.contentWidth*0.2
			returnButton = widget.newButton
			{
				defaultFile = "reset.png",
				overFile = "reset.png",
				width=wh, height=wh,
				labelColor = {default = {0,0,0}},
				onEvent = function()
			   		composer.gotoScene("levelselect",{effect = "fade",time = 500})
			    end
			}
			returnButton.isVisible = false
			returnButton.x = display.actualContentWidth*0.5
			returnButton.y = display.actualContentHeight*0.75
			sceneGroup:insert(returnButton)
			timer.performWithDelay(2000, function ()
				returnButton.isVisible = true
			end)

			
	end
end

function scene:textPressed()
	local sceneGroup = self.view
	-- body
	if (question_counter > 0) then
		if not textOn then
			transition.to(contentScreen, {y = display.contentHeight/2.2, height = display.actualContentHeight*0.85, time = 800
						})

			contentArea:removeSelf()


			contentArea = widget.newScrollView(
		    {
		        x = display.contentWidth*0.5,
		        y = display.contentHeight*0.47,
				width = display.contentWidth*0.95,
				height = display.contentHeight*0.7,
		        scrollWidth = 600,
		        scrollHeight = 800,
		        horizontalScrollDisabled = true
		    })	--contentArea:setFillColor(1,0,0)
		    sceneGroup:insert(contentArea)
		    contentArea.isVisible = false
		    myParagraph = Wrapper:newParagraph({
			text = testData.text,
			width = display.contentWidth*0.9,
			height = display.contentHeight/3, 		-- fontSize will be calculated automatically if set 
			font = "Times New Roman", 	-- make sure the selected font is installed on your system
			fontSize = 16,			
			lineSpace = 2,
			alignment  = "left",
			
			-- Parameters for speed tweaking, just relevant if height is set
			fontSizeMin = 20,
			fontSizeMax = 40,
			incrementSize = 2
			})
			myParagraph:setTextColor({0,0,0})
			contentArea:insert(myParagraph)

			timer.performWithDelay(2000,function()
				contentArea.isVisible = true
			end)

			textOn = true

			for i=1,3 do
			questions[i].text.isHitTestable = false
			end
		
		else
			transition.to(contentScreen, {y = display.contentHeight/3.1, height = display.actualContentHeight*0.45, time = 800
						})

			display.remove(myParagraph)
			contentArea:removeSelf()
			display.remove( contentArea )
			myParagraph = nil
			
			contentArea = widget.newScrollView(
		    {
		        x = display.contentWidth*0.5,
		        y = display.contentHeight/3.1,
		        width = display.contentWidth*0.95,
		        height = display.contentHeight*0.4,
		        scrollWidth = 600,
		        scrollHeight = 800,
		        horizontalScrollDisabled = true
		    })	--contentArea:setFillColor(1,0,0)
		    sceneGroup:insert(contentArea)
		    		    contentArea.isVisible = false

			myParagraph = Wrapper:newParagraph({

			text = testData.questions[question_counter].text,
			width = display.contentWidth*0.9,
			height = display.contentHeight*0.75, 		-- fontSize will be calculated automatically if set 
			font = "Times New Roman", 	-- make sure the selected font is installed on your system
			fontSize = 16,			
			lineSpace = 2,
			alignment  = "left",
			
			-- Parameters for speed tweaking, just relevant if height is set
			fontSizeMin = 20,
			fontSizeMax = 40,
			incrementSize = 2
			})
			myParagraph:setTextColor({0,0,0})
			contentArea:insert(myParagraph)
			textOn = false
			for i=1,3 do
			questions[i].text.isHitTestable = true
			end
			timer.performWithDelay(2000,function()
				contentArea.isVisible = true
			end)
		end
	end
	--print("textbtn touched")
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene