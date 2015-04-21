float[][][][] colorspace;
color[][][] colors;

void initMeshColors() {
  colorspace=new float[dimX][dimY][dimZ][3];  
  colors=new color[dimX][dimY][dimZ];
}

//this part is mostly Alasdair Turner' code made 3d by Tomasso Casucci

void initReaction() {
  a = new float [dimX ][ dimY ][ dimZ ][2];
  b = new float [dimX ][ dimY ][ dimZ ][2];
  c = new float [dimX ][ dimY ][ dimZ ][2];

  for (int x = 0; x < dimX; x++) {
    for (int y = 0; y < dimY; y++) {
      for (int z = 0; z< dimZ; z++) {
        a[x][y][z][p] = random (1);
        b[x][y][z][p] = random (1);
        c[x][y][z][p] = random (1);
      }
    }
  }
}

void updateReaction() {
  if (gridres != oldgridres) {
    input = new float[dimY][gridres][gridres];
    oldgridres = gridres;
  }
  for (int x = 0; x < dimX; x++) {
    for (int y = 0; y < dimY; y++) {
      for (int z = 0; z < dimZ; z++) {
        float c_a = 0.0;
        float c_b = 0.0;
        float c_c = 0.0;

        for (int i = x - 1; i <= x+1; i++) {
          for (int j = y - 1; j <= y+1; j++) {
            for (int k = z - 1; k <= z+1; k++) {
              c_a += a[(i+dimX )% dimX ][(j+dimY )% dimY ][(k+dimZ )% dimZ ][p];
              c_b += b[(i+dimX )% dimX ][(j+dimY )% dimY ][(k+dimZ )% dimZ ][p];
              c_c += c[(i+dimX )% dimX ][(j+dimY )% dimY ][(k+dimZ )% dimZ ][p];
            }
          }
        }

        c_a /= 27.0;
        c_b /= 27.0;
        c_c /= 27.0;
        // adjust these values to alter behaviour
        a[x][y][z][q] = constrain(c_a + c_a * (c_b - c_c), 0, 1);
        b[x][y][z][q] = constrain(c_b + c_b * (c_c - c_a), 0, 1);
        c[x][y][z][q] = constrain(c_c + c_c * (c_a - c_b), 0, 1);


        float vValue=fTrp(map(sin(a[x][y][z][q]*9), -1, 1, 0, 1), -0.5, -0.4, 0.4, 0.5);
        volume.setVoxelAt(x, y, z, vValue);

        colorspace[x][y][z][0]=a[x][y][z][q];
        colorspace[x][y][z][1]=b[x][y][z][q];
        colorspace[x][y][z][2]=c[x][y][z][q];

        if (y%floorDensity==0)input[y][x][z] = a[x][y][z][q];//update floor slab input array
      }
    }
  }
  if (p == 0) {
    p = 1; 
    q = 0;
  }
  else {
    p = 0; 
    q = 1;
  }
}

void updateMesh() {
  volume.closeSides();
  mesh=new WETriangleMesh("iso"); 
  IsoSurface surface=new HashIsoSurface(volume, 0.333333);
  surface.computeSurfaceMesh(mesh, ISO_THRESHOLD);
  new LaplacianSmooth().filter(mesh, 1);
}

void updateColors() {
  if (uniform) {
    for (int x = 0; x < dimX; x++) {
      for (int y = 0; y < dimY; y++) {
        for (int z = 0; z < dimZ; z++) {
          colors[x][y][z]=color(map(sin(colorspace[x][y][z][0]*rFreq), -1, 1, 0, rIntens), map(sin(colorspace[x][y][z][0]*gFreq), -1, 1, 0, gIntens), map(sin(colorspace[x][y][z][0]*bFreq), -1, 1, 0, bIntens));
        }
      }
    }
  }
  else {
    for (int x = 0; x < dimX; x++) {
      for (int y = 0; y < dimY; y++) {
        for (int z = 0; z < dimZ; z++) {
          colors[x][y][z]=color(map(sin(colorspace[x][y][z][0]*rFreq), -1, 1, 0, rIntens), map(sin(colorspace[x][y][z][1]*gFreq), -1, 1, 0, gIntens), map(sin(colorspace[x][y][z][2]*bFreq), -1, 1, 0, bIntens));
        }
      }
    }
  }
}

