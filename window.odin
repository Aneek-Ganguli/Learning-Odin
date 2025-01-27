package main
import "core:fmt"
import SDL "vendor:sdl2"
import IMG "vendor:sdl2/image"

Window :: struct {
	window:       ^SDL.Window,
	renderer:     ^SDL.Renderer,
	isFullscreen: bool,
	width:        i32,
	height:       i32,
	windowFlags:  SDL.WindowFlags,
}

initilizeWindow :: proc(
	window: ^Window,
	p_title: cstring,
	p_width: i32,
	p_height: i32,
	p_isFullscreen: bool,
) {
	window.window = nil
	window.renderer = nil
	window.windowFlags = nil
	window.width = p_width
	window.height = p_height
	if (p_isFullscreen == true) {
		window.isFullscreen = true
		window.windowFlags = SDL.WINDOW_SHOWN | SDL.WINDOW_FULLSCREEN
	} else {
		window.isFullscreen = false
		window.windowFlags = SDL.WINDOW_SHOWN
	}
	window.window = SDL.CreateWindow(
		p_title,
		SDL.WINDOWPOS_UNDEFINED,
		SDL.WINDOWPOS_UNDEFINED,
		window.width,
		window.height,
		window.windowFlags,
	)
	window.renderer = SDL.CreateRenderer(
		window.window,
		-1,
		SDL.RENDERER_ACCELERATED | SDL.RENDERER_PRESENTVSYNC,
	)
	if window.window == nil {
		fmt.println("FAILED TO INITILIZED WINDOW. Error: ", SDL.GetError())
	}

	if window.renderer == nil {
		fmt.println("FAILED TO INITLIZED RENDERER .Error: ", SDL.GetError())
	}
}

cleanUp :: proc(window: ^Window) {
	SDL.DestroyWindow(window.window)
	SDL.DestroyRenderer(window.renderer)
}

display :: proc(window: ^Window) {
	SDL.RenderPresent(window.renderer)
}

clear :: proc(window: ^Window) {
	SDL.RenderClear(window.renderer)
}

loadTexture :: proc(window: ^Window, p_filePath: cstring) -> ^SDL.Texture {
	texture: ^SDL.Texture
	texture = nil
	texture = IMG.LoadTexture(window.renderer, p_filePath)
	if texture == nil {
		fmt.println("Failed to load texture .Error: ", IMG.GetError())
	}
	return texture
}

renderTexure :: proc(window: ^Window, tex: ^SDL.Texture, x: i32, y: i32, width: i32, height: i32) {
	//position in the texture
	src: SDL.Rect
	src.x = x
	src.y = y
	src.w = width
	src.h = height

	dst: SDL.Rect
	dst.x = x * 2
	dst.y = y * 2
	//Scale append_nothing()
	dst.w = width * 2
	dst.h = height * 2
	SDL.RenderCopy(window.renderer, tex, &src, &dst)
}

renderEntity :: proc(window: ^Window, entity: ^Entity) {
	//current frame
	src: SDL.Rect
	src = entity.currentFrame

	dst: SDL.Rect
	dst.x = entity.x
	dst.y = entity.y
	dst.w = entity.currentFrame.w
	dst.h = entity.currentFrame.h
	SDL.RenderCopy(window.renderer, entity.texture, &src, &dst)
}

