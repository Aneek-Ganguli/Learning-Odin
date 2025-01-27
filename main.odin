package main
import "core:fmt"
import SDL "vendor:sdl2"
import IMG "vendor:sdl2/image"

main :: proc() {
	if (SDL.Init(SDL.INIT_VIDEO) > 0) {
		fmt.println("HEY .. SDL_Init HAS FAILED. SDL_ERROR", SDL.GetError())
	}


	img_init := IMG.Init(IMG.INIT_PNG)
	if (img_init & IMG.INIT_PNG) != IMG.INIT_PNG {
		fmt.eprintfln("Error initializing SDL2_image: %s", IMG.GetError())
	}

	window: Window
	initilizeWindow(&window, "Hello World", 800, 600, true)
	tex: ^SDL.Texture = loadTexture(&window, "res/player.png")

	entity: Entity
	initilizeEntity(&entity, tex, 0, 0, 32, 32)

	isRunning: bool = true
	event: SDL.Event
	for isRunning == true {
		for SDL.PollEvent(&event) {
			if (event.type == SDL.EventType.QUIT) {
				isRunning = false
			}

			if (event.type == SDL.EventType.KEYDOWN) {
				if (event.key.keysym.sym == SDL.Keycode.d) {
					setPos(&entity, entity.x + 1, entity.y)
				}
				if (event.key.keysym.sym == SDL.Keycode.A) {
					setPos(&entity, entity.x - 1, entity.y)
				}
				//its not much
			}

		}

		if (entity.y > 800) {
			entity.y = 0
		}

		clear(&window)
		setPos(&entity, entity.x, entity.y + 10)
		renderEntity(&window, &entity)
		//setPos(&entity, entity.x + 1, 0) //entity.y + 1)
		display(&window)

	}
	cleanUp(&window)
	SDL.Quit()
}

