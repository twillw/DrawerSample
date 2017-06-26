
typealias StyleBlock = (_ view: UIView) -> Void

class {{ className }} {


    // MARK: instance variables

    var styles = [String: StyleBlock]()

    [
    {
        name: ,
        className: ,
        properties: [
            {
                propertyName: ,
                value:
            }
        ]
    }
    ]

    private init() {

        // add style blocks

        {{ #styles }}

        styles["{{ name }}"] = {
            view in

            if let {{ className.toLowerCase() }} = view as? {{ className }} {


            }

        }

        {{ /styles }}

    }

}