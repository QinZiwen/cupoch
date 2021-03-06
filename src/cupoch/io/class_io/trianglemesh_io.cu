#include "cupoch/io/class_io/trianglemesh_io.h"
#include "cupoch/geometry/trianglemesh.h"

using namespace cupoch;
using namespace cupoch::io;

void HostTriangleMesh::FromDevice(const geometry::TriangleMesh& trianglemesh) {
    vertices_.resize(trianglemesh.vertices_.size());
    vertex_normals_.resize(trianglemesh.vertex_normals_.size());
    vertex_colors_.resize(trianglemesh.vertex_colors_.size());
    triangles_.resize(trianglemesh.triangles_.size());
    triangle_normals_.resize(trianglemesh.triangle_normals_.size());
    triangle_uvs_.resize(trianglemesh.triangle_uvs_.size());
    utility::CopyFromDeviceMultiStream(trianglemesh.vertices_, vertices_);
    utility::CopyFromDeviceMultiStream(trianglemesh.vertex_normals_, vertex_normals_);
    utility::CopyFromDeviceMultiStream(trianglemesh.vertex_colors_, vertex_colors_);
    utility::CopyFromDeviceMultiStream(trianglemesh.triangles_, triangles_);
    utility::CopyFromDeviceMultiStream(trianglemesh.triangle_normals_, triangle_normals_);
    utility::CopyFromDeviceMultiStream(trianglemesh.triangle_uvs_, triangle_uvs_);
    texture_.FromDevice(trianglemesh.texture_);
    cudaDeviceSynchronize();
}

void HostTriangleMesh::ToDevice(geometry::TriangleMesh& trianglemesh) const {
    trianglemesh.vertices_.resize(vertices_.size());
    trianglemesh.vertex_normals_.resize(vertex_normals_.size());
    trianglemesh.vertex_colors_.resize(vertex_colors_.size());
    trianglemesh.triangles_.resize(triangles_.size());
    trianglemesh.triangle_normals_.resize(triangle_normals_.size());
    trianglemesh.triangle_uvs_.resize(triangle_uvs_.size());
    utility::CopyToDeviceMultiStream(vertices_, trianglemesh.vertices_);
    utility::CopyToDeviceMultiStream(vertex_normals_, trianglemesh.vertex_normals_);
    utility::CopyToDeviceMultiStream(vertex_colors_, trianglemesh.vertex_colors_);
    utility::CopyToDeviceMultiStream(triangles_, trianglemesh.triangles_);
    utility::CopyToDeviceMultiStream(triangle_normals_, trianglemesh.triangle_normals_);
    utility::CopyToDeviceMultiStream(triangle_uvs_, trianglemesh.triangle_uvs_);
    texture_.ToDevice(trianglemesh.texture_);
    cudaDeviceSynchronize();
}

void HostTriangleMesh::Clear() {
    vertices_.clear();
    vertex_normals_.clear();
    vertex_colors_.clear();
    triangles_.clear();
    triangle_normals_.clear();
    triangle_uvs_.clear();
    texture_.Clear();
}