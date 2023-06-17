// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:fic_bloc2/bloc/add_product/add_product_bloc.dart';
import 'package:fic_bloc2/bloc/products/products_bloc.dart';
import 'package:fic_bloc2/data/models/request/product_request_model.dart';
import 'package:fic_bloc2/data/models/response/product_response_model.dart';
import 'package:fic_bloc2/presentation/widgets/add_product_page/camera_page.dart';
import 'package:fic_bloc2/presentation/widgets/add_product_page/pick_image.dart';
import 'package:fic_bloc2/shared/widgets/text_input.dart';

class AddProductPage extends StatefulWidget {
  final bool? isEdit;
  final ProductResponseModel? product;
  const AddProductPage({
    Key? key,
    this.isEdit,
    this.product,
  }) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  XFile? picture;

  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();

    if (widget.isEdit!) {
      titleController?.text = widget.product!.title!;
      priceController?.text = widget.product!.price!.toString();
      descriptionController?.text = widget.product!.description!;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (model) {
            //display dialog success adding product
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Berhasil Cuk'),
                backgroundColor: Colors.indigoAccent,
              ),
            );

            context
                .read<ProductsBloc>()
                .add(AddSingleProductsEvent(data: model));
            context.read<ProductsBloc>().add(GetProductsEvent());

            Navigator.pop(context);
          },
          error: (message) {
            //display dialog failed adding product
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error Cuk: $message'),
                backgroundColor: Colors.red,
              ),
            );
            Navigator.pop(context);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          orElse: () {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.isEdit! ? "Update Product" : "Add Product"),
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                ),
              ),
              body: SafeArea(
                minimum: const EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    PickImage(
                      radius: 90,
                      child: picture != null
                          ? Image.file(File(picture!.path))
                          : const SizedBox(
                              height: 110,
                              width: 110,
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                      onCamera: () async {
                        log("Open Camera....");
                        //navigate to camera page
                        //and come back bring image data
                        await availableCameras().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraPage(
                                  takePicture: takePicture,
                                  cameras: value,
                                ),
                              ),
                            ));
                      },
                      onGallery: () {
                        log("Open Gallery....");
                        //get image from gallery
                        getImage(ImageSource.gallery);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      label: "Title",
                      controller: titleController,
                    ),
                    TextInput(
                      label: 'Price',
                      controller: priceController,
                    ),
                    TextInput(
                      label: 'Description',
                      controller: descriptionController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  final model = ProductRequestModel(
                    title: titleController!.text,
                    price: int.parse(priceController!.text),
                    description: descriptionController!.text,
                  );

                  context
                      .read<AddProductBloc>()
                      .add(AddProductEvent.addProduct(model));
                },
                backgroundColor: Colors.deepPurple,
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
