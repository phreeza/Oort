#ifndef PARTICLE_H
#define PARTICLE_H

enum particle_type {
	PARTICLE_HIT,
	PARTICLE_PLASMA,
	PARTICLE_ENGINE,
};

struct particle {
	complex float p, v;
	unsigned short ticks_left;
	unsigned char type;
	char padding;
};

#define MAX_PARTICLES 65536
extern struct particle particles[MAX_PARTICLES];

void particle_create(enum particle_type type, complex float p, complex float v, unsigned short lifetime);
void particle_shower(enum particle_type type,
		                 complex float p0, complex float v0, complex float v, float s_max,
										 unsigned short life_min, unsigned short life_max,
										 unsigned short count);
void particle_tick(void);

#endif
