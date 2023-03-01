@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="form-group">
            <label for="id">id</label> <input type="number" name="id" class="form-control" id="id" placeholder="id" size="11" readonly>
        </div>
        <div class="form-group">
            <label for="name">name</label> <input type="text" name="name" class="form-control" id="name" placeholder="name" size="255">
        </div>
        <div class="form-group">
            <label for="contact">contact</label> <input type="number" name="contact" class="form-control" id="contact" placeholder="contact" size="20">
        </div>
        <div class="form-group">
            <label for="r_sph">r_sph</label> <input type="text" name="r_sph" class="form-control" id="r_sph" placeholder="r_sph" size="">
        </div>
        <div class="form-group">
            <label for="r_cyl">r_cyl</label> <input type="text" name="r_cyl" class="form-control" id="r_cyl" placeholder="r_cyl" size="">
        </div>
        <div class="form-group">
            <label for="r_aixs">r_aixs</label> <input type="text" name="r_aixs" class="form-control" id="r_aixs" placeholder="r_aixs" size="">
        </div>
        <div class="form-group">
            <label for="l_sph">l_sph</label> <input type="text" name="l_sph" class="form-control" id="l_sph" placeholder="l_sph" size="">
        </div>
        <div class="form-group">
            <label for="l_cpl">l_cpl</label> <input type="text" name="l_cpl" class="form-control" id="l_cpl" placeholder="l_cpl" size="">
        </div>
        <div class="form-group">
            <label for="l_aixs">l_aixs</label> <input type="text" name="l_aixs" class="form-control" id="l_aixs" placeholder="l_aixs" size="">
        </div>
        <div class="form-group">
            <label for="r_sph_multiplier">r_sph_multiplier</label> <input type="text" name="r_sph_multiplier" class="form-control" id="r_sph_multiplier" placeholder="r_sph_multiplier" size="">
        </div>
        <div class="form-group">
            <label for="r_cyl_multiplier">r_cyl_multiplier</label> <input type="text" name="r_cyl_multiplier" class="form-control" id="r_cyl_multiplier" placeholder="r_cyl_multiplier" size="">
        </div>
        <div class="form-group">
            <label for="r_aixs_multiplier">r_aixs_multiplier</label> <input type="text" name="r_aixs_multiplier" class="form-control" id="r_aixs_multiplier" placeholder="r_aixs_multiplier" size="">
        </div>
        <div class="form-group">
            <label for="l_sph_multiplier">l_sph_multiplier</label> <input type="text" name="l_sph_multiplier" class="form-control" id="l_sph_multiplier" placeholder="l_sph_multiplier" size="">
        </div>
        <div class="form-group">
            <label for="l_cyl_multiplier">l_cyl_multiplier</label> <input type="text" name="l_cyl_multiplier" class="form-control" id="l_cyl_multiplier" placeholder="l_cyl_multiplier" size="">
        </div>
        <div class="form-group">
            <label for="l_aixs_multiplier">l_aixs_multiplier</label> <input type="text" name="l_aixs_multiplier" class="form-control" id="l_aixs_multiplier" placeholder="l_aixs_multiplier" size="">
        </div>


    </div>
</div>
@endsection