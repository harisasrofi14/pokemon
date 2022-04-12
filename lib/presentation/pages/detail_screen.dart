import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/domain/entities/pokemon.dart';
import 'package:pokemon/presentation/widgets/type_container.dart';

class DetailScreen extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final Pokemon pokemon;

  const DetailScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.4 :MediaQuery.of(context).size.height * 0.9 ,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.pokemon.number,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  )),
                              const SizedBox(height: 5,),
                              Text(
                                widget.pokemon.name,
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                              const SizedBox(height: 5,),
                              Text(widget.pokemon.classification)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.pokemon.types.length,
                              itemBuilder: (context, index) {
                                return TypeContainer(
                                    widget.pokemon.types[index]);
                              }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: DataTable(
                          headingRowHeight: 0,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(''),
                            ),
                            DataColumn(
                              label: Text(''),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                const DataCell(Text('Max HP')),
                                DataCell(Text(widget.pokemon.maxHp.toString())),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                const DataCell(Text('Max CP')),
                                DataCell(Text(widget.pokemon.maxCp.toString())),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                const DataCell(Text('Flee Rate')),
                                DataCell(
                                    Text(widget.pokemon.fleeRate.toString())),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            imageUrl: widget.pokemon.image,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )),
                            ),
                            fit: BoxFit.scaleDown,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
