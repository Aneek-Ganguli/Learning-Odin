package main
import "core:fmt"
import SDL "vendor:sdl2"
import IMG "vendor:sdl2/image"

Entity :: struct {
	texture:      ^SDL.Texture,
	currentFrame: SDL.Rect,
	x:            i32,
	y:            i32,
	w:            i32,
	h:            i32,
}

initilizeEntity :: proc(entity: ^Entity, p_texture: ^SDL.Texture, x: i32, y: i32, w: i32, h: i32) {
	entity.texture = p_texture
	//entity.currentFrame.x = x * 4
	//entity.currentFrame.y = y * 4
	entity.x = x * 2
	entity.y = y * 2
	entity.currentFrame.w = w * 2
	entity.currentFrame.h = h * 2
}

//we use pointers bcuz we need to change the porperties of the original entity
setPos :: proc(entity: ^Entity, x: i32, y: i32) {
	entity.x = x
	entity.y = y
	//entity.currentFrame.x = entity.x * 4
	//entity.currentFrame.y = entity.y * 4
}

