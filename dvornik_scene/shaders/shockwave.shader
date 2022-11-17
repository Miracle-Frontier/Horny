shader_type canvas_item;

//uniform vec4 flash_color: hint_color = vec4(1.0); // export variable
//uniform float flash_modifier: hint_range(0.0,1.0) = 1;

//uniform float scale : hint_range(-2, 10) = 2.0; // Можно анимировать через AnimationPlayer
//uniform sampler2D gradient;
//uniform sampler2D curve;

uniform vec2 center = vec2(0.5,0.5);
uniform float force = 111; // сила distortion
uniform float size = 0.3;
uniform float thickness;
// TIME cos( VERTEX)
// void vertex() выполняется для каждого угла https://www.youtube.com/watch?v=xoyk_A0RSpI
void fragment()
{
	// И много чего еще в плейлисте шейдеров (эффекты огня, итд) (ссылка https://www.youtube.com/watch?v=1pJyYtBAHks)

	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y; // ratio
	vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0); // Мы будем скейлить x, чтобы он подходил под аспект y . Оффсеттим его на 0.5, делим на ratio, и возвращаем на 0.5
	float mask = 1.0 - smoothstep(size,size+0.1,length(scaledUV - center)); // Длина вектора, смотрящего из центра в сторону UV (Длина означает силу цвета) (Плюс через step в любой точке до порога будет 0, а после -1, а через smoothstep, мы сделали интерполяцию между двумя ступенями, чтобы был не просто 0) Плюс, инвертация - 1.0
	float donut_mask = smoothstep(size-thickness-0.1,size-thickness,length(scaledUV - center))*mask; 
	// Маска применяет distortion только в своей зоне (Потому что любое число *0 = 0, очень просто)
	vec2 disp = normalize(scaledUV - center) * force * donut_mask; // Вектор, смотрящий из центра в Сторону UV
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp); // Прибавляем disp к UV (мы прибавляем искажение центра)
	//COLOR.rgb = vec3(donut_mask);

	//COLOR = texture(SCREEN_TEXTURE, SCREEN_UV-vec2(0.1,0)); // загружает sampler2D
	//COLOR = vec4(SCREEN_UV-disp, 0.0, 1.0); // К UV прибавляем distortion ()
			
	// Именно так создаются волны, distortionом от шума и сдвижением шага
	// Distortion в зависимости от картинки (Так же дополнительно можно генерировать шумы, и прочее, инфа тут: https://www.youtube.com/watch?v=1pJyYtBAHks)
	//vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).a * 0.1; // В зависимости от альфы будет увеличиваться искревление
	//vec4 screenColor = texture(SCREEN_TEXTURE, distortedUV);
	// COLOR = screenColor;
	// Get screen
	//vec4 screenColor = texture(SCREEN_TEXTURE, SCREEN_UV); // Get Screen pixel 
	//COLOR = screenColor;
	
	// Curves и много чего еще в плейлисте шейдеров (ссылка https://www.youtube.com/watch?v=1pJyYtBAHks))
	//vec2 vecToCenter = vec2(0.5, 0.5) - UV; // Вычитание координаты текущего пикселя из центра (Расстояние отсюда до центра)
	//float distToCenter = length(vecToCenter);
	//float curveValue = texture(curve, vec2(distToCenter)).r; // Получить red в зависимости от длины до центра и в зависимости от кривой
	//vec2 diff = normalize(vecToCenter) * 0.6 * curveValue; // Вычислить девиацию от screen_uv 
	//COLOR = texture(SCREEN_TEXTURE, SCREEN_UV-diff);
	

	// Получение текстуры градиента и смешивание
	//vec4 pixelColor = texture(TEXTURE, UV);
	//vec4 gradientColor = texture(gradient, UV); // uniform sampler2D gradient;
	//COLOR = pixelColor + gradientColor * 0.4;
	

	
	// Почему нужен texture()
	//vec4 pixelColor = texture(TEXTURE, UV); 
	//COLOR = pixelColor; // Изначально COLOR в vec3, поэтому без texture() он применяется на все
	//COLOR.rgb = COLOR.rrr;

	// Весь код прогоняется для одного пикселя каждый раз (UV - Координата текущего пикселя)
	//vec4 pixel_color = texture(TEXTURE, UV); // получаем цвет пикселя согласно текущему UV и текстуре из которой получаем
	//float brightness = (pixel_color.r+pixel_color.g+pixel_color.b)/3.0; // Получаем освещение - просто цвет пикселя вместе поделить на 3
	//COLOR = vec4(brightness, brightness, brightness, pixel_color.a); // Применяем его

	// Искревление пикселей
//	vec2 distortedUV = UV;
//	distortedUV.x += distortedUV.y * 0.2;
//	vec4 color = texture(TEXTURE, distortedUV);
//	COLOR = color; 

// Микс цветов (флэш)
//	vec4 color = texture(TEXTURE, UV);
//	color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
//	COLOR = color;
}

// Микс цветов
//void fragment()
//{
//	vec4 color = texture(TEXTURE, UV); // Gets color
//	color.rgb = mix(color.rgb, vec3(1,1,1).rgb, 0.5);
//	COLOR = color;
//}